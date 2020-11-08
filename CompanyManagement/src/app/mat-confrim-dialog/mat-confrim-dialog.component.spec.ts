import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { MatConfrimDialogComponent } from './mat-confrim-dialog.component';

describe('MatConfrimDialogComponent', () => {
  let component: MatConfrimDialogComponent;
  let fixture: ComponentFixture<MatConfrimDialogComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ MatConfrimDialogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MatConfrimDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
