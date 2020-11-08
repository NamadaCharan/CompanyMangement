import { Injectable } from '@angular/core';
import { ToastrService } from 'ngx-toastr';

@Injectable({
  providedIn: 'root'
})
export class ToasterService {

  constructor(private toastrService: ToastrService) { }
  timeout = { timeOut: 3500 }

  successMsg(title,message) {
     this.toastrService.success(title, message,this.timeout)
  }

  warnMsg(title, message) {
    this.toastrService.warning(title, message, this.timeout)
  }

  errorMsg(title,message) {
    this.toastrService.error(title, message, this.timeout)
  }

}
