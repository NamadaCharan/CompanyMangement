import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from "@angular/forms";
import { CompanyDetails } from 'src/app/Models/CompanyDetails';
import { MatDialogRef } from '@angular/material/dialog';
import { CompanyService } from 'src/app/shared/company.service';
import { MatTableDataSource } from '@angular/material/table';
import { BaseResponse } from 'src/app/Models/BaseResponse';
import { ToasterService } from 'src/app/shared/toaster.service';

@Component({
  selector: 'app-addcompanydetails',
  templateUrl: './addcompanydetails.component.html',
  styleUrls: ['./addcompanydetails.component.css']
})
export class AddcompanydetailsComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<AddcompanydetailsComponent>,
    public companyService: CompanyService,
    private toasterService: ToasterService) { }

  ngOnInit(): void {

  }
  companyDetails: CompanyDetails = new CompanyDetails();
  addCompany: FormGroup = new FormGroup({
    companyName: new FormControl('', Validators.required),
    address: new FormControl(''),
    city: new FormControl(''),
    state: new FormControl('')
  });
  OnSubmit() {
    if (this.addCompany.valid) {
      this.companyDetails.companyName = this.addCompany.value.companyName;
      this.companyDetails.city = this.addCompany.value.city;
      this.companyDetails.state = this.addCompany.value.state;
      this.companyDetails.address = this.addCompany.value.address;
      this.companyService.addCompanyDetails(this.companyDetails).subscribe(res => {
        this.companyService.getCompanyDetails().subscribe(data => {
          var result = res as BaseResponse
          if (result.isSuccess) {
            if (data) {
              this.companyService.listData = new MatTableDataSource(data as CompanyDetails[]);
              this.companyService.listData.sort = this.companyService.sort;
              this.companyService.listData.paginator = this.companyService.paginator;
            }
            this.toasterService.successMsg('Success', result.message)
          }
          else {
            this.toasterService.errorMsg('Failure', result.message)
          }
        })
      })
      this.addCompany.reset();
      this.dialogRef.close();
    }
  }

  onClose() {
    this.addCompany.reset();
    this.dialogRef.close();
  }
}
