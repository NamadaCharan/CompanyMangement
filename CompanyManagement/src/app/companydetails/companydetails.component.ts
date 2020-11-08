import { Component, OnInit, ViewChild } from '@angular/core';
import { CompanyService } from 'src/app/shared/company.service';
import { CompanyDetails } from 'src/app/Models/CompanyDetails';
import { MatTableDataSource } from '@angular/material/table';
import { MatSort } from '@angular/material/sort';
import { MatPaginator } from '@angular/material/paginator';
import { MatDialogConfig, MatDialog } from '@angular/material/dialog';
import { AddcompanydetailsComponent } from 'src/app/addcompanydetails/addcompanydetails.component';
import { AddcontactcompanydetailsComponent } from 'src/app/addcontactcompanydetails/addcontactcompanydetails.component';
import { Router } from '@angular/router';
import { StatusCode } from 'src/app/Models/StatusCode';
import { MatSelect } from "@angular/material/select";

@Component({
  selector: 'app-companydetails',
  templateUrl: './companydetails.component.html',
  styleUrls: ['./companydetails.component.css']
})
export class CompanydetailsComponent implements OnInit {
  selectedEvent: any;

  displayedColumns: string[] = ['companyName', 'address', 'city', 'state', 'status', 'actions'];
  pageSizeOptionsArray = [1, 5, 10, 25, 100];
  @ViewChild(MatSort) sort: MatSort;
  @ViewChild(MatPaginator) paginator: MatPaginator;
  public companyDetails: CompanyDetails[] = [];
  public filterDetails: CompanyDetails[] = [];
  statusCode: StatusCode[];
  constructor(public companyService: CompanyService,
    private dialog: MatDialog,
    private router: Router) {

  }

  ngOnInit(): void {
    this.getCompanyDetails();
    this.getStatus();
  }
  getStatus() {
    this.companyService.getStatusCode().subscribe(data => {
      let result = data as StatusCode[];
      this.statusCode = result;
      this.companyService.disableClearButton = true;
    })
  }
  getCompanyDetails() {
    this.companyService.getCompanyDetails().subscribe(data => {
      if (data) {
        this.companyDetails = data as CompanyDetails[];
        this.filterDetails = this.companyDetails;
        this.setCompanyData(this.filterDetails)
      }
      else {
        this.companyDetails = [];
        this.companyService.listData = new MatTableDataSource(this.companyDetails);

      }
    }, error => (
      (this.companyDetails = [])
    ))
  }


  changeStatusValue(event) {
    this.selectedEvent = event
    this.companyService.disableClearButton = false
    this.filterDetails = this.companyDetails.filter(data => {
      if (data.statusId === event.value) {
        return data
      }
    })
    this.setCompanyData(this.filterDetails)

  }

  onClearFilter() {
    this.companyService.disableClearButton = true;
    const matSelect: MatSelect = this.selectedEvent.source;
    matSelect.writeValue(null);
    this.setCompanyData(this.companyDetails)
  }


  setCompanyData(data) {
    this.statusCode = this.statusCode
    this.companyService.listData = new MatTableDataSource(data);
    this.companyService.sort = this.sort;
    this.companyService.paginator = this.paginator;
    this.companyService.listData.sort = this.sort;
    this.companyService.listData.paginator = this.paginator;

  }
  NaviagteIntoDetails(element) {
    this.router.navigate(['/companyDetails', element.companyId])
  }

  AddNewCompany() {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.disableClose = true;
    dialogConfig.autoFocus = true;
    dialogConfig.width = "50%";
    this.dialog.open(AddcompanydetailsComponent, dialogConfig);
  }

  AddUserContact(element) {
    this.companyService.companyId = element.companyId;
    const dialogConfig = new MatDialogConfig();
    dialogConfig.disableClose = true;
    dialogConfig.autoFocus = true;
    dialogConfig.width = "50%";
    this.dialog.open(AddcontactcompanydetailsComponent, dialogConfig)
  }

}
