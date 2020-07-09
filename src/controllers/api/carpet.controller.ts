import { Controller, Post, Body, Param, UseInterceptors, UploadedFile, Req, Delete, Patch, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { Carpet } from "src/entities/carpet.entity";
import { CarpetService } from "src/services/carpet/carpet.service";
import { AddCarpetDto } from "src/dtos/carpet/add.carpet.dto";
import { FileInterceptor } from '@nestjs/platform-express';
import { StorageConfig } from "config/storage.config";
import { diskStorage } from "multer";
import { PhotoService } from "src/services/photo/photo.service";
import { Photo } from "src/entities/photo.entity";
import { ApiResponse } from "src/misc/api.response.class";
import * as fileType from 'file-type';
import * as fs from 'fs';
import * as sharp from 'sharp';
import { EditCarpetDto } from "src/dtos/carpet/edit.carpet.dto";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { CarpetSearchDto } from "src/dtos/carpet/carpet.search.dto";

@Controller('api/carpet')
@Crud({
    model: {
        type: Carpet
    },
    params: {
        id: {
            field: 'carpetId',
            type: 'number',
            primary: true
        }
    },
    query: {
        join: {
            category: {
                eager: true
            },
            photos: {
                eager: true
            },
            carpetPrices: {
                eager: true
            }
        }
    },
    routes: {
        only: [
            'getOneBase',
            'getManyBase',
        ],
        getOneBase: {
            decorators: [
                UseGuards(RoleCheckedGuard),
                AllowToRoles('administrator', 'user')
            ],
        },
        getManyBase: {
            decorators: [
                UseGuards(RoleCheckedGuard),
                AllowToRoles('administrator', 'user')
            ],
        },
    },
})
export class CarpetController {
    constructor(
        public service: CarpetService,
        public photoService: PhotoService,
    ) { }

    @Post() // POST http://localhost:3000/api/carpet/
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    createFullCarpet(@Body() data: AddCarpetDto) {
        return this.service.createFullCarpet(data);
    }

    @Patch(':id') // PATCH http://localhost:3000/api/carpet/2/
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    editFullCarpet(@Param('id') id: number, @Body() data: EditCarpetDto) {
        return this.service.editFullCarpet(id, data);
    }

    @Post(':id/uploadPhoto/') // POST http://localhost:3000/api/carpet/:id/uploadPhoto/
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    @UseInterceptors(
        FileInterceptor('photo', {
            storage: diskStorage({
                destination: StorageConfig.photo.destination,
                filename: (req, file, callback) => {
                    let original: string = file.originalname;

                    let normalized = original.replace(/\s+/g, '-');
                    normalized = normalized.replace(/[^A-z0-9\.\-]/g, '');
                    let sada = new Date();
                    let datePart = '';
                    datePart += sada.getFullYear().toString();
                    datePart += (sada.getMonth() + 1).toString();
                    datePart += sada.getDate().toString();

                    let randomPart: string =
                        new Array(10)
                            .fill(0)
                            .map(e => (Math.random() * 9).toFixed(0).toString())
                            .join('');

                    let fileName = datePart + '-' + randomPart + '-' + normalized;
                    fileName = fileName.toLocaleLowerCase();

                    callback(null, fileName);
                }
            }),
            fileFilter: (req, file, callback) => {
                // 1. Check ekstenzije: JPG, PNG
                if (!file.originalname.toLowerCase().match(/\.(jpg|png)$/)) {
                    req.fileFilterError = 'Bad file extension!';
                    callback(null, false);
                    return;
                }

                // 2. Check tipa sadrzaja: image/jpeg, image/png (mimetype)
                if (!(file.mimetype.includes('jpeg') || file.mimetype.includes('png'))) {
                    req.fileFilterError = 'Bad file content type!';
                    callback(null, false);
                    return;
                }

                callback(null, true);
            },
            limits: {
                files: 1,
                fileSize: StorageConfig.photo.maxSize,
            },
        })
    )
    async uploadPhoto(
        @Param('id') carpetId: number,
        @UploadedFile() photo,
        @Req() req
    ): Promise<ApiResponse | Photo> {
        if (req.fileFilterError) {
            return new ApiResponse('error', -4002, req.fileFilterError);
        }

        if (!photo) {
            return new ApiResponse('error', -4002, 'File not uploaded!');
        }

        const fileTypeResult = await fileType.fromFile(photo.path);
        if (!fileTypeResult) {
            fs.unlinkSync(photo.path);
            return new ApiResponse('error', -4002, 'Cannot detect file type!');
        }

        const realMimeType = fileTypeResult.mime;
        if (!(realMimeType.includes('jpeg') || realMimeType.includes('png'))) {
            fs.unlinkSync(photo.path);
            return new ApiResponse('error', -4002, 'Bad file content type!');
        }

        await this.createResizedImage(photo, StorageConfig.photo.resize.thumb);
        await this.createResizedImage(photo, StorageConfig.photo.resize.small);

        const newPhoto: Photo = new Photo();
        newPhoto.carpetId = carpetId;
        newPhoto.imagePath = photo.filename;

        const savedPhoto = await this.photoService.add(newPhoto);
        if (!savedPhoto) {
            return new ApiResponse('error', -4001);
        }

        return savedPhoto;
    }

    async createResizedImage(photo, resizeSettings) {
        const originalFilePath = photo.path;
        const fileName = photo.filename;

        const destinationFilePath =
            StorageConfig.photo.destination +
            resizeSettings.directory +
            fileName;

        await sharp(originalFilePath)
            .resize({
                fit: 'cover',
                width: resizeSettings.width,
                height: resizeSettings.height,
            })
            .toFile(destinationFilePath);
    }

    // http://localhost:3000/api/carpet/1/deletePhoto/45/
    @Delete(':carpetId/deletePhoto/:photoId')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    public async deletePhoto(
        @Param('carpetId') carpetId: number,
        @Param('photoId') photoId: number,
    ) {
        const photo = await this.photoService.findOne({
            carpetId: carpetId,
            photoId: photoId
        });

        if (!photo) {
            return new ApiResponse('error', -4004, 'Photo not found!');
        }

        try {
            fs.unlinkSync(StorageConfig.photo.destination + photo.imagePath);
            fs.unlinkSync(StorageConfig.photo.destination +
                        StorageConfig.photo.resize.thumb.directory +
                        photo.imagePath);
            fs.unlinkSync(StorageConfig.photo.destination +
                        StorageConfig.photo.resize.small.directory +
                        photo.imagePath);
        } catch (e) { }

        const deleteResult = await this.photoService.deleteById(photoId);

        if (deleteResult.affected === 0) {
            return new ApiResponse('error', -4004, 'Photo not found!');
        }

        return new ApiResponse('ok', 0, 'One photo deleted!');
    }

    @Post('search')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator', 'user')
    async search(@Body() data: CarpetSearchDto): Promise<Carpet[] | ApiResponse> {
        return await this.service.search(data);
    }
}
