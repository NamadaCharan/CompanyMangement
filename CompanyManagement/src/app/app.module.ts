import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MaterialModule } from 'src/app/material/material.module';
import { CompanydetailsComponent } from './companydetails/companydetails.component';
import { CompanyService } from 'src/app/shared/company.service';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { AddcompanydetailsComponent } from './addcompanydetails/addcompanydetails.component';
import { AddcontactcompanydetailsComponent } from './addcontactcompanydetails/addcontactcompanydetails.component';
import { AppRoutingModule } from 'src/app/app-routing/app-routing.module';
import { HeaderComponent } from './shared/header/header.component';
import { CompanyinfoComponent } from './companyinfo/companyinfo.component';
import { MatConfrimDialogComponent } from './mat-confrim-dialog/mat-confrim-dialog.component';
import { DialogService } from 'src/app/shared/dialog.service';
import { SpinnerComponent } from 'src/app/shared/spinner/spinner.component';
import { SpinnerService } from 'src/app/shared/spinner.service';
import { AddproductComponent } from './addproduct/addproduct.component';
import { PieChatsComponent } from './pie-chats/pie-chats.component';
import { ToastrModule } from 'ngx-toastr';
import { ToasterService } from 'src/app/shared/toaster.service';
import { LoaderInterceptor } from 'src/app/shared/Interceptor';
@NgModule({
  declarations: [
    AppComponent,
    CompanydetailsComponent,
    AddcompanydetailsComponent,
    AddcontactcompanydetailsComponent,
    HeaderComponent,
    CompanyinfoComponent,
    MatConfrimDialogComponent,
    SpinnerComponent,
    AddproductComponent,
    PieChatsComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    MaterialModule,
    ReactiveFormsModule,
    HttpClientModule,
    AppRoutingModule,
    FormsModule,
    ToastrModule.forRoot({progressBar:true})
  ],
  providers: [CompanyService,DialogService,SpinnerService,ToasterService,
    {
      provide: HTTP_INTERCEPTORS,
      useClass: LoaderInterceptor ,
      multi: true
    }],
  bootstrap: [AppComponent]
})
export class AppModule { }
