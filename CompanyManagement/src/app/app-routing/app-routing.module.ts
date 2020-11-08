import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { CompanydetailsComponent } from 'src/app/companydetails/companydetails.component';
import { CompanyinfoComponent } from 'src/app/companyinfo/companyinfo.component';

const routes: Routes = [
  {
    path:'',
    redirectTo:'companyDetails',
    pathMatch:'full'
  },
  {
    path: 'companyDetails',
     component: CompanydetailsComponent
},
  {
      path: 'companyDetails/:id',
       component: CompanyinfoComponent
  },
];
@NgModule({
  declarations: [],
  imports: [
    RouterModule.forRoot(routes)
  ],
  exports:[RouterModule]
})
export class AppRoutingModule { }
