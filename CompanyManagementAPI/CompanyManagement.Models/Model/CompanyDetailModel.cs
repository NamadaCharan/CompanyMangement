using System;
using System.Collections.Generic;
using System.Text;

namespace CompanyManagement.Models.Model
{
   public class CompanyDetailModel:Response
    {
        public CompanyDetailModel()
        {
            contactDetails = new List<ContactDetailsModel>();
        }
        public CompanyDetailsModel companyDetails { get; set; }
        public List<ContactDetailsModel> contactDetails { get; set; }
        public int  NextStatusId { get; set; }
        public string NextStatusDescription { get; set; }
    }
}
