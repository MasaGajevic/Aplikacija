import * as Validator from 'class-validator';

export class EditCarpetDto {
    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(5, 128)
    name: string;

    categoryId: number;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(10, 255)
    excerpt: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(64, 10000)
    description: string;

    @Validator.IsNotEmpty()
    @Validator.IsPositive()
    @Validator.IsNumber({
        allowInfinity: false,
        allowNaN: false,
        maxDecimalPlaces: 2,
    })
    price: number;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.IsIn(["XXL", "XL", "XXXL"])
    status: 'XXL' | 'XL' | 'XXXL';

    @Validator.IsNotEmpty()
    @Validator.IsIn([0, 1])
    isPromoted: 0 | 1;

}
