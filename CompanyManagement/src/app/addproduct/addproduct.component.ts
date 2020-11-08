import { Component, OnInit, OnDestroy } from '@angular/core';
import { CompanyService } from 'src/app/shared/company.service';
import { Products } from 'src/app/Models/Products';
import { MatDialogRef } from '@angular/material/dialog';
import { Items } from 'src/app/Models/Items';
import { BaseResponse } from 'src/app/Models/BaseResponse';
import { SpinnerService } from 'src/app/shared/spinner.service';
import { ToasterService } from 'src/app/shared/toaster.service';
import { ActivatedRoute } from '@angular/router';
import { ProductDetailsForChat } from 'src/app/Models/ProductDetailsForChat';

@Component({
  selector: 'app-addproduct',
  templateUrl: './addproduct.component.html',
  styleUrls: ['./addproduct.component.css']
})
export class AddproductComponent implements OnInit, OnDestroy {


  ngOnDestroy() {
    this.companyService.datatoPopulate = [];
    this.companyService.labelsPresent = [];
  }
  constructor(public companyService: CompanyService,
    public dialogRef: MatDialogRef<AddproductComponent>,
    private toasterService: ToasterService,
    private route: ActivatedRoute) { }
  products: Products[];
  inputEntered: number;
  errorDisplay: boolean;
  selectedProduct: number = 0;
  selectedError: boolean = true;
  calculatedAmount: number = 0;
  items: Items = new Items();
  ngOnInit(): void {
    this.inputEntered = 1;
    this.companyService.getProducts().subscribe(response => {
      this.products = response as Products[]
    })
  }
  changedEnteredValue() {
    if (this.inputEntered <= 0) {
      this.calculatedAmount = 0
      this.errorDisplay = true;
    }
    else {
      this.calculateAmount();
      this.errorDisplay = false;
    }
  }

  changeProductValue(value) {
    this.selectedProduct = value;
    this.selectedError = false;
    this.calculateAmount();
  }

  calculateAmount() {
    this.products.forEach(element => {
      if (element.productId === this.selectedProduct) {
        this.calculatedAmount = (element.productCost * this.inputEntered)
      }
    });
  }

  onBuy() {
    if (this.selectedProduct == -1) {
      return;
    }
    this.onClose();
    this.companyService.showGraph = false;
    this.items.userId = this.companyService.userId;
    this.items.productId = this.selectedProduct;
    this.items.noOfItems = this.inputEntered;
    this.companyService.addProducts(this.items).subscribe(res => {
      let result = res as BaseResponse;
      if (result.isSuccess) {
        this.toasterService.successMsg('Success', result.message);
        this.updateProductChat()
      }
      else {
        this.toasterService.errorMsg('Failure', result.message)
      }
    })
  }

  onClose() {
    this.dialogRef.close();
  }

  updateProductChat() {
    this.route.paramMap.subscribe(params => {
      let id = params.get('id');
      this.companyService.getProductDetailsForChat(id).subscribe(result => {
        let response = result as ProductDetailsForChat[];
        this.companyService.productDetailsForChat = response;
      })
    });
  }
}
