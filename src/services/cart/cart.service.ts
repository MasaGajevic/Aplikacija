import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Cart } from "src/entities/cart.entity";
import { Repository } from "typeorm";
import { CartCarpet } from "src/entities/cart-carpet.entity";
import { Carpet } from "src/entities/carpet.entity";
import { Order } from "src/entities/order.entity";

@Injectable()
export class CartService {
    constructor(
        @InjectRepository(Cart)
        private readonly cart: Repository<Cart>,
 
        @InjectRepository(CartCarpet)
        private readonly cartCarpet: Repository<CartCarpet>,
    ) { }

    async getLastActiveCartByUserId(userId: number): Promise<Cart | null> {
        const carts = await this.cart.find({
            where: {
                userId: userId,
            },
            order: {
                createdAt: "DESC",
            },
            take: 1,
            relations: [ "order" ],
        });

        if (!carts || carts.length === 0) {
            return null;
        }

        const cart = carts[0];

        if (cart.order !== null) {
            return null;
        }

        return cart;
    }

    async createNewCartForUser(userId: number): Promise<Cart> {
        const newCart: Cart = new Cart();
        newCart.userId = userId;
        return await this.cart.save(newCart);
    }

    async addCarpetToCart(cartId: number, carpetId: number, quantity: number): Promise<Cart> {
        let record: CartCarpet = await this.cartCarpet.findOne({
            cartId: cartId,
            carpetId: carpetId,
        });

        if (!record) {
            record = new CartCarpet();
            record.cartId = cartId;
            record.carpetId = carpetId;
            record.quantity = quantity;
        } else {
            record.quantity += quantity;
        }

        await this.cartCarpet.save(record);

        return this.getById(cartId);
    }

    async getById(cartId: number): Promise<Cart> {
        return await this.cart.findOne(cartId, {
            relations: [
                "user",
                "cartCarpets",
                "cartCarpets.carpet",
                "cartCarpets.carpet.category",
                "cartCarpets.carpet.carpetPrices",
            ],
        });
    }

    async changeQuantity(cartId: number, carpetId: number, newQuantity: number): Promise<Cart> {
        let record: CartCarpet = await this.cartCarpet.findOne({
            cartId: cartId,
            carpetId: carpetId,
        });

        if (record) {
            record.quantity = newQuantity;

            if (record.quantity === 0) {
                await this.cartCarpet.delete(record.cartCarpetId);
            } else {
                await this.cartCarpet.save(record);
            }
        }

        return await this.getById(cartId);
    }
}
