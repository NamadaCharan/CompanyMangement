import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CompanyService } from 'src/app/shared/company.service';
import { CompanyDetail } from 'src/app/Models/CompanyDetail';
import { CompanyDetails } from 'src/app/Models/CompanyDetails';
import { DialogService } from 'src/app/shared/dialog.service';
import { SpinnerService } from 'src/app/shared/spinner.service';
import { MatDialog, MatDialogConfig } from '@angular/material/dialog';
import { AddproductComponent } from 'src/app/addproduct/addproduct.component';

@Component({
  selector: 'app-companyinfo',
  templateUrl: './companyinfo.component.html',
  styleUrls: ['./companyinfo.component.css']
})
export class CompanyinfoComponent implements OnInit {
  companyDetails: CompanyDetails = new CompanyDetails();
  displayedColumns: string[] = ['fullName', 'email', 'mobile', 'actions']
  constructor(private route: ActivatedRoute,
    private companyService: CompanyService,
    private dialogService: DialogService,
    private spinnerService: SpinnerService, private matdialog: MatDialog) { }
  public companyDetail: CompanyDetail
  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      let id = params.get('id')
      this.getCompanyDetails(id)
    })
  }


  getCompanyDetails(id) {
    this.spinnerService.openDialog()
    this.companyService.getCompanyDetailsById(id)
      .subscribe(res => {
        if (res) {
          this.companyDetail = res as CompanyDetail
          this.companyService.statusId = this.companyDetail.companyDetails.statusId;
        }
        else {

        }
        this.spinnerService.closeDialog()
      }
      )

  }
  ChangeStatus(nextChangeId) {
    this.spinnerService.openDialog();
    this.companyDetails.companyId = this.companyDetail.companyDetails.companyId;
    this.companyDetails.companyName = this.companyDetail.companyDetails.companyName;
    this.companyDetails.statusId = nextChangeId;
    this.companyDetails.statusDescription = this.companyDetail.nextStatusDescription;
    this.companyDetails.state = this.companyDetail.companyDetails.state;
    this.companyDetails.city = this.companyDetail.companyDetails.city;
    this.companyDetails.address = this.companyDetail.companyDetails.address;
    this.companyService.updateStatus(this.companyDetails).subscribe(res => {
      this.companyDetail = res as CompanyDetail
      this.companyService.statusId = this.companyDetail.companyDetails.statusId;
      this.spinnerService.closeDialog()
    }, error => {
      //Error
      this.spinnerService.closeDialog()
    });
  }
  OpenConfirmDialog(statusId) {
    this.companyService.statusId = statusId;
    this.dialogService.openConfirmDialog().afterClosed().subscribe(res => {
      this.ChangeStatus(res)
    })
  }

  onBuyClick(userId) {
    this.companyService.userId = userId;
    const dialogConfig = new MatDialogConfig();
    dialogConfig.disableClose = true;
    dialogConfig.autoFocus = true;
    dialogConfig.width = "30%";
    this.matdialog.open(AddproductComponent, dialogConfig)
  }

}
