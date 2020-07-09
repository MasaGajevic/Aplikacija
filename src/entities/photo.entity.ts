import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn
} from "typeorm";
import { Carpet } from "./carpet.entity";
import * as Validator from 'class-validator';

@Index("fk_photo_carpet_id", ["carpetId"], {})
@Index("uq_photo_image_path", ["imagePath"], { unique: true })
@Entity("photo")
export class Photo {
  @PrimaryGeneratedColumn({ type: "int", name: "photo_id", unsigned: true })
  photoId: number;

  @Column({ type: "int", name: "carpet_id", unsigned: true })
  carpetId: number;

  @Column({
    type: "varchar",
    name: "image_path",
    unique: true,
    length: 128
  })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(1, 128)
  imagePath: string;

  @ManyToOne(
    () => Carpet,
    carpet => carpet.photos,
    { onDelete: "NO ACTION", onUpdate: "CASCADE" }
  )
  @JoinColumn([{ name: "carpet_id", referencedColumnName: "carpetId" }])
  carpet: Carpet;
}
