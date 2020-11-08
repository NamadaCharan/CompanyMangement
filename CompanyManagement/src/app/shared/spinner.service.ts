import { Injectable, OnInit, OnDestroy } from '@angular/core';
import { MatDialogRef, MatDialog } from '@angular/material/dialog';
import { SpinnerComponent } from 'src/app/shared/spinner/spinner.component';

@Injectable({
  providedIn: 'root'
})
export class SpinnerService implements OnInit, OnDestroy {

  dialogRef: MatDialogRef<SpinnerComponent>
  constructor(private dialog: MatDialog) { }


  ngOnInit(): void {

  }
  ngOnDestroy(): void {
    this.closeDialog();
  }

  public openDialog() {
    if (this.dialogRef) {
      this.dialogRef.close();
    }
    this.dialogRef = this.dialog.open(SpinnerComponent);
    this.dialogRef.disableClose = true;
  }

  public closeDialog() {
    this.dialogRef.close();
  }
}
