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

@Index("fk_carpet_price_carpet_id", ["carpetId"], {})
@Entity("carpet_price")
export class CarpetPrice {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "carpet_price_id",
    unsigned: true
  })
  carpetPriceId: number;

  @Column({ type: "int", name: "carpet_id", unsigned: true })
  carpetId: number;

  @Column({
    type: "decimal",
    unsigned: true,
    precision: 10,
    scale: 2
  })
  @Validator.IsNotEmpty()
  @Validator.IsPositive()
  @Validator.IsNumber({
    allowInfinity: false,
    allowNaN: false,
    maxDecimalPlaces: 2,
  })
  price: number;

  @Column({
    type: "timestamp",
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP"
  })
  createdAt: Date;

  @ManyToOne(
    () => Carpet,
    carpet => carpet.carpetPrices,
    { onDelete: "NO ACTION", onUpdate: "CASCADE" }
  )
  @JoinColumn([{ name: "carpet_id", referencedColumnName: "carpetId" }])
  carpet: Carpet;
}
