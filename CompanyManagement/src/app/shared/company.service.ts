import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { MatTableDataSource } from '@angular/material/table';
import { MatSort } from '@angular/material/sort';
import { MatPaginator } from '@angular/material/paginator';
import { ProductDetailsForChat } from 'src/app/Models/ProductDetailsForChat';
import { Chart } from 'chart.js';
@Injectable({
  providedIn: 'root'
})
export class CompanyService {
disableClearButton=true;
  labelsPresent= [];
  datatoPopulate=[];
  listData: MatTableDataSource<any>;
  companyId: number;
  sort: MatSort;
  paginator: MatPaginator;
  statusId: number;
  userId: number;
  showGraph=false;
  productDetailsForChat:ProductDetailsForChat[];
  readonly baseUrl = "https://localhost:44380/api/";
  constructor(private http: HttpClient) { }

  getStatusCode () {
    return this.http.get(this.baseUrl+"CompanyManagement/GetStatus")
  }
  getCompanyDetails() {
    return this.http.get(this.baseUrl + "CompanyManagement/CompanyDetails")
  }
  setCompanyId(id) {
    this.companyId = id;
  }
  addContactDetails(user) {
    return this.http.post(this.baseUrl + "CompanyManagement/AddUserContact", user)
  }

  addCompanyDetails(CompanyInfo) {
    return this.http.post(this.baseUrl + "CompanyManagement/AddComapanyDeatils", CompanyInfo)

  }

  getCompanyDetailsById(id) {
    return this.http.get(this.baseUrl + "CompanyManagement/CompanyDetails/" + id)
  }

  updateStatus(companyDetailsTobeUpdated) {
    return this.http.put(this.baseUrl + "CompanyManagement/UpdateStatus", companyDetailsTobeUpdated)
  }

  getProducts() {
    return this.http.get(this.baseUrl + "CompanyManagement/GetProductDetails")
  }

  addProducts(products) {
    return this.http.post(this.baseUrl + "CompanyManagement/AddOrUpdateItems", products)
  }
  getProductDetailsForChat(companyId) {
    return this.http.get(this.baseUrl + "CompanyManagement/GetProductDetailsForChat/" + companyId);
  }



}
