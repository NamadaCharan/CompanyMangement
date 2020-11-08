import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PieChatsComponent } from './pie-chats.component';

describe('PieChatsComponent', () => {
  let component: PieChatsComponent;
  let fixture: ComponentFixture<PieChatsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PieChatsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PieChatsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
