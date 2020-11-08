import { Component, OnInit, OnDestroy } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';

@Component({
  selector: 'app-spinner',
  templateUrl: './spinner.component.html',
  styleUrls: ['./spinner.component.css']
})
export class SpinnerComponent implements OnInit, OnDestroy {
	constructor(public dialogRef: MatDialogRef<SpinnerComponent>) {

	}

	public ngOnInit() {

	}

	public ngOnDestroy() {
		this.dialogRef.close();
	}
}

