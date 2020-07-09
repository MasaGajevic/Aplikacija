import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn
} from "typeorm";
import { Carpet } from "./carpet.entity";
import { Cart } from "./cart.entity";
import * as Validator from 'class-validator';

@Index("fk_cart_carpet_carpet_id", ["carpetId"], {})
@Index("uq_cart_carpet_cart_id_carpet_id", ["cartId", "carpetId"], { unique: true })
@Entity("cart_carpet")
export class CartCarpet {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "cart_carpet_id",
    unsigned: true
  })
  cartCarpetId: number;

  @Column({ type: "int", name: "cart_id", unsigned: true })
  cartId: number;

  @Column({ type: "int", name: "carpet_id", unsigned: true })
  carpetId: number;

  @Column({ type: "int", unsigned: true })
  @Validator.IsNotEmpty()
  @Validator.IsPositive()
  @Validator.IsNumber({
    allowInfinity: false,
    allowNaN: false,
    maxDecimalPlaces: 0,
  })
  quantity: number;

  @ManyToOne(
    () => Carpet,
    carpet => carpet.cartCarpets,
    { onDelete: "NO ACTION", onUpdate: "CASCADE" }
  )
  @JoinColumn([{ name: "carpet_id", referencedColumnName: "carpetId" }])
  carpet: Carpet;

  @ManyToOne(
    () => Cart,
    cart => cart.cartCarpets,
    { onDelete: "NO ACTION", onUpdate: "CASCADE" }
  )
  @JoinColumn([{ name: "cart_id", referencedColumnName: "cartId" }])
  cart: Cart;
}
