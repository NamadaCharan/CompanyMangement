import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AddcontactcompanydetailsComponent } from './addcontactcompanydetails.component';

describe('AddcontactcompanydetailsComponent', () => {
  let component: AddcontactcompanydetailsComponent;
  let fixture: ComponentFixture<AddcontactcompanydetailsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AddcontactcompanydetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AddcontactcompanydetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
