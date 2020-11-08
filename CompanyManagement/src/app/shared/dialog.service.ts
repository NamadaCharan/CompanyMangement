import { Injectable } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatConfrimDialogComponent } from 'src/app/mat-confrim-dialog/mat-confrim-dialog.component';

@Injectable({
  providedIn: 'root'
})
export class DialogService {

  constructor(private dialog:MatDialog) { }
  openConfirmDialog(){
    return this.dialog.open(MatConfrimDialogComponent,{
      width:'400px',
      panelClass:'confirm-dialog-container',
      disableClose:true
    });
  }
}
