import { Module, NestModule, MiddlewareConsumer } from '@nestjs/common';
import { AppController } from './controllers/app.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseConfiguration } from 'config/database.configuration';
import { Administrator } from 'src/entities/administrator.entity';
import { AdministratorService } from './services/administrator/administrator.service';
import { CarpetPrice } from 'src/entities/carpet-price.entity';
import { Carpet } from 'src/entities/carpet.entity';
import { CartCarpet } from 'src/entities/cart-carpet.entity';
import { Cart } from 'src/entities/cart.entity';
import { Category } from 'src/entities/category.entity';
import { Order } from 'src/entities/order.entity';
import { Photo } from 'src/entities/photo.entity';
import { User } from 'src/entities/user.entity';
import { AdministratorController } from './controllers/api/administrator.controller';
import { CategoryController } from './controllers/api/category.controller';
import { CategoryService } from './services/category/category.service';
import { CarpetService } from './services/carpet/carpet.service';
import { CarpetController } from './controllers/api/carpet.controller';
import { AuthController } from './controllers/api/auth.controller';
import { AuthMiddleware } from './middlewares/auth.middleware';
import { PhotoService } from './services/photo/photo.service';
import { UserService } from './services/user/user.service';
import { CartService } from './services/cart/cart.service';
import { UserCartController } from './controllers/api/user.cart.controller';
import { OrderService } from './services/order/order.service';
import { MailerModule } from '@nestjs-modules/mailer';
import { MailConfig } from 'config/mail.config';
import { OrderMailer } from './services/order/order.mailer.service';
import { AdministratorOrderController } from './controllers/api/administrator.order.controller';
import { UserToken } from './entities/user-token.entity';
import { AdministratorToken } from './entities/administrator-token.entity';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: DatabaseConfiguration.hostname,
      port: 3306,
      username: DatabaseConfiguration.username,
      password: DatabaseConfiguration.password,
      database: DatabaseConfiguration.database,
      entities: [
        Administrator,
        CarpetPrice,
        Carpet,
        CartCarpet,
        Cart,
        Category,
        Order,
        Photo,
        User,
        UserToken,
        AdministratorToken,
      ]
    }),
    TypeOrmModule.forFeature([
      Administrator,
      CarpetPrice,
      Carpet,
      CartCarpet,
      Cart,
      Category,
      Order,
      Photo,
      User,
      UserToken,
      AdministratorToken,
    ]),
    MailerModule.forRoot({
      transport: 'smtps://' + MailConfig.username + ':' +
                              MailConfig.password + '@' +
                              MailConfig.hostname,
      defaults: {
        from: MailConfig.senderEmail,
      },
    }),
  ],
  controllers: [
    AppController,
    AdministratorController,
    CategoryController,
    CarpetController,
    AuthController,
    UserCartController,
    AdministratorOrderController,
  ],
  providers: [
    AdministratorService,
    CategoryService,
    CarpetService,
    PhotoService,
    UserService,
    CartService,
    OrderService,
    OrderMailer,
  ],
  exports: [
    AdministratorService,
    UserService,
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(AuthMiddleware)
      .exclude('auth/*')
      .forRoutes('api/*');
  }
}
