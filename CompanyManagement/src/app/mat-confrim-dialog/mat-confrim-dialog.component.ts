import { Component, OnInit } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { CompanyService } from 'src/app/shared/company.service';

@Component({
  selector: 'app-mat-confrim-dialog',
  templateUrl: './mat-confrim-dialog.component.html',
  styleUrls: ['./mat-confrim-dialog.component.css']
})
export class MatConfrimDialogComponent implements OnInit {

  constructor(public matDialogRef:MatDialogRef<MatConfrimDialogComponent>,
    public companyService:CompanyService) { }

  ngOnInit(): void {
  }

  closeDialog(){
    this.matDialogRef.close(false)
  }
}
