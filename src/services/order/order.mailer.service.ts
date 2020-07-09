import { Injectable } from "@nestjs/common";
import { Order } from "src/entities/order.entity";
import { MailerService } from "@nestjs-modules/mailer";
import { MailConfig } from "config/mail.config";
import { CartCarpet } from "src/entities/cart-carpet.entity";

@Injectable()
export class OrderMailer {
    constructor(private readonly mailerService: MailerService) { }

    async sendOrderEmail(order: Order): Promise<boolean> {
        try {
            await this.mailerService.sendMail({
                to: order.cart.user.email,
                bcc: MailConfig.orderNotificationMail,
                subject: 'Order details',
                encoding: 'UTF-8',
                html: this.makeOrderHtml(order),
            });

            return true;
        } catch (e) {
            return false;
        }
    }

    private makeOrderHtml(order: Order): string {
        let suma = order.cart.cartCarpets.reduce((sum, current: CartCarpet) => {
            return sum +
                   current.quantity *
                   current.carpet.carpetPrices[current.carpet.carpetPrices.length-1].price
        }, 0);

        return `<p>Zahvaljujemo se za Vašu porudžbinu!</p>
                <p>Ovo su detalji Vaše porudžbine:</p>
                <ul>
                    ${ order.cart.cartCarpets.map((cartCarpet: CartCarpet) => {
                        return `<li>
                            ${ cartCarpet.carpet.name } x
                            ${ cartCarpet.quantity }
                        </li>`;
                    }).join("") }
                </ul>
                <p>Ukupan iznos je: ${ suma.toFixed(2) } EUR.</p>
                <p>Potpis...</p>`;
    }
}
