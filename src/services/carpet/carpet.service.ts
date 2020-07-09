import { Injectable } from "@nestjs/common";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository, In } from "typeorm";
import { Carpet } from "src/entities/carpet.entity";
import { AddCarpetDto } from "src/dtos/carpet/add.carpet.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { CarpetPrice } from "src/entities/carpet-price.entity";
import { EditCarpetDto } from "src/dtos/carpet/edit.carpet.dto";
import { CarpetSearchDto } from "src/dtos/carpet/carpet.search.dto";

@Injectable()
export class CarpetService extends TypeOrmCrudService<Carpet> {
    constructor(
        @InjectRepository(Carpet)
        private readonly carpet: Repository<Carpet>,

        @InjectRepository(CarpetPrice)
        private readonly carpetPrice: Repository<CarpetPrice>,
    ) {
        super(carpet);
    }

    async createFullCarpet(data: AddCarpetDto): Promise<Carpet | ApiResponse> {
        let newCarpet: Carpet = new Carpet();
        newCarpet.name        = data.name;
        newCarpet.categoryId  = data.categoryId;
        newCarpet.excerpt     = data.excerpt;
        newCarpet.description = data.description;

        let savedCarpet = await this.carpet.save(newCarpet);

        let newCarpetPrice: CarpetPrice = new CarpetPrice();
        newCarpetPrice.carpetId = savedCarpet.carpetId;
        newCarpetPrice.price     = data.price;

        await this.carpetPrice.save(newCarpetPrice);


        return await this.carpet.findOne(savedCarpet.carpetId, {
            relations: [
                "category",
                "carpetPrices",
                "photos"
            ]
        });
    }

    async editFullCarpet(carpetId: number, data: EditCarpetDto): Promise<Carpet | ApiResponse> {
        const existingCarpet: Carpet = await this.carpet.findOne(carpetId, {
            relations: [ 'carpetPrices' ]
        });

        if (!existingCarpet) {
            return new ApiResponse('error', -5001, 'Carpet not found.');
        }

        existingCarpet.name        = data.name;
        existingCarpet.categoryId  = data.categoryId;
        existingCarpet.excerpt     = data.excerpt;
        existingCarpet.description = data.description;
        existingCarpet.status      = data.status;
        existingCarpet.isPromoted  = data.isPromoted;

        const savedCarpet = await this.carpet.save(existingCarpet);
        if (!savedCarpet) {
            return new ApiResponse('error', -5002, 'Could not save new carpet data.');
        }

        const newPriceString: string = Number(data.price).toFixed(2); // 50.1 -> "50.10"
        const lastPrice = existingCarpet.carpetPrices[existingCarpet.carpetPrices.length-1].price;
        const lastPriceString: string = Number(lastPrice).toFixed(2); // 50 -> "50.00"

        if (newPriceString !== lastPriceString) {
            const newCarpetPrice = new CarpetPrice();
            newCarpetPrice.carpetId = carpetId;
            newCarpetPrice.price = data.price;

            const savedCarpetPrice = await this.carpetPrice.save(newCarpetPrice);
            if (!savedCarpetPrice) {
                return new ApiResponse('error', -5003, 'Could not save the new carpet price.');
            }
        }

        return await this.carpet.findOne(carpetId, {
            relations: [
                "category",
                "carpetPrices"
            ]
        });
    }

    async search(data: CarpetSearchDto): Promise<Carpet[] | ApiResponse> {
        const builder = await this.carpet.createQueryBuilder("carpet");

        builder.innerJoinAndSelect(
            "carpet.carpetPrices",
            "ap",
            "ap.createdAt = (SELECT MAX(ap.created_at) FROM carpet_price AS ap WHERE ap.carpet_id = carpet.carpet_id)"
        );

        builder.leftJoinAndSelect("carpet.photos", "photos");

        builder.where('carpet.categoryId = :catId', { catId: data.categoryId });

        if (data.keywords && data.keywords.length > 0) {
            builder.andWhere(`(
                                carpet.name LIKE :kw OR
                                carpet.excerpt LIKE :kw OR
                                carpet.description LIKE :kw
                              )`,
                              { kw: '%' + data.keywords.trim() + '%' });
        }

        if (data.priceMin && typeof data.priceMin === 'number') {
            builder.andWhere('ap.price >= :min', { min: data.priceMin });
        }

        if (data.priceMax && typeof data.priceMax === 'number') {
            builder.andWhere('ap.price <= :max', { max: data.priceMax });
        }

        let orderBy = 'carpet.name';
        let orderDirection: 'ASC' | 'DESC' = 'ASC';

        if (data.orderBy) {
            orderBy = data.orderBy;

            if (orderBy === 'price') {
                orderBy = 'ap.price';
            }
    
            if (orderBy === 'name') {
                orderBy = 'carpet.name';
            }
        }

        if (data.orderDirection) {
            orderDirection = data.orderDirection;
        }

        builder.orderBy(orderBy, orderDirection);

        let page = 0;
        let perPage: 5 | 10 | 25 | 50 | 75 = 25;

        if (data.page && typeof data.page === 'number') {
            page = data.page;
        }

        if (data.itemsPerPage && typeof data.itemsPerPage === 'number') {
            perPage = data.itemsPerPage;
        }

        builder.skip(page * perPage);
        builder.take(perPage);

        let carpets = await builder.getMany();

        if (carpets.length === 0) {
            return new ApiResponse("ok", 0, "No carpets found for these search parameters.");
        }

        return carpets;
    }
}
