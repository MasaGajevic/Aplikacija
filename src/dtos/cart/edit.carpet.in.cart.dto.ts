import * as Validator from 'class-validator';

export class EditCarpetInCartDto {
    carpetId: number;

    @Validator.IsNotEmpty()
    @Validator.IsNumber({
        allowInfinity: false,
        allowNaN: false,
        maxDecimalPlaces: 0,
    })
    quantity: number;
}
