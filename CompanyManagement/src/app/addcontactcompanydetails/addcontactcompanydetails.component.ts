import { Component, OnInit } from '@angular/core';
import { CompanyService } from 'src/app/shared/company.service';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { MatDialogRef } from '@angular/material/dialog';
import { ContactDetails } from 'src/app/Models/ContactDetails';
import { SpinnerService } from 'src/app/shared/spinner.service';
import { BaseResponse } from 'src/app/Models/BaseResponse';
import { ToasterService } from 'src/app/shared/toaster.service';

@Component({
  selector: 'app-addcontactcompanydetails',
  templateUrl: './addcontactcompanydetails.component.html',
  styleUrls: ['./addcontactcompanydetails.component.css']
})
export class AddcontactcompanydetailsComponent implements OnInit {

  contactDetails: ContactDetails = new ContactDetails();
  constructor(public companyService: CompanyService,
    public dialogRef: MatDialogRef<AddcontactcompanydetailsComponent>,
    private toasterService: ToasterService) { }
  addUser: FormGroup = new FormGroup({
    companyId: new FormControl(this.companyService.companyId),
    fullName: new FormControl('', Validators.required),
    email: new FormControl('', Validators.email),
    mobile: new FormControl('', [Validators.required, Validators.minLength(8)]),
    gender: new FormControl('1')
  });
  ngOnInit(): void {

  }
  onClose() {
    this.addUser.reset();
    this.dialogRef.close();
  }

  OnSubmit() {
    if (this.addUser.valid) {
      this.contactDetails.companyId = this.addUser.value.companyId;
      this.contactDetails.fullName = this.addUser.value.fullName;
      this.contactDetails.genderId = this.addUser.value.gender;
      this.contactDetails.mobile = this.addUser.value.mobile;
      this.contactDetails.email = this.addUser.value.email;
      this.companyService.addContactDetails(this.contactDetails).subscribe(res => {
        let result = res as BaseResponse
        if (result.isSuccess) {
          this.toasterService.successMsg('Success', result.message)
        }
        else {
          //error
          this.toasterService.errorMsg('Failure', result.message)
        }
      })
      this.dialogRef.close();
    }
  }
}
