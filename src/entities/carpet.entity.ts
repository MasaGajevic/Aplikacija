import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  JoinTable,
  ManyToMany
} from "typeorm";
import { Category } from "./category.entity";
import { CarpetPrice } from "./carpet-price.entity";
import { CartCarpet } from "./cart-carpet.entity";
import { Photo } from "./photo.entity";
import * as Validator from 'class-validator';

@Index("fk_carpet_category_id", ["categoryId"], {})
@Entity("carpet")
export class Carpet {
  @PrimaryGeneratedColumn({ type: "int", name: "carpet_id", unsigned: true })
  carpetId: number;

  @Column({ type: "varchar", length: 128 })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(5, 128)
  name: string;

  @Column({ type: "int", name: "category_id", unsigned: true })
  categoryId: number;

  @Column({ type: "varchar", length: 255 })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(10, 255)
  excerpt: string;

  @Column({ type: "text" })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(64, 10000)
  description: string;

  @Column({
    type: "enum",
    enum: ["XXL", "XL", "XXXL"],
    default: () => "'XXL'"
  })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.IsIn(["XXL", "XL", "XXXL"])
  status: "XXL" | "XL" | "XXXL";

  @Column({
    type: "tinyint",
    name: "is_promoted",
    unsigned: true
  })
  @Validator.IsNotEmpty()
  @Validator.IsIn([0, 1])
  isPromoted: number;

  @Column({
    type: "timestamp",
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP"
  })
  createdAt: Date;

  @ManyToOne(
    () => Category,
    category => category.carpets,
    { onDelete: "NO ACTION", onUpdate: "CASCADE" }
  )
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;

  @OneToMany(
    () => CarpetPrice,
    carpetPrice => carpetPrice.carpet
  )
  carpetPrices: CarpetPrice[];

  @OneToMany(
    () => CartCarpet,
    cartCarpet => cartCarpet.carpet
  )
  cartCarpets: CartCarpet[];

  @OneToMany(
    () => Photo,
    photo => photo.carpet
  )
  photos: Photo[];
}
