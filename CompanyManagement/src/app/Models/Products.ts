import { BaseResponse } from 'src/app/Models/BaseResponse';

export class Products extends BaseResponse {
    productId: number;
    productName: string;
    productCost: number;
}