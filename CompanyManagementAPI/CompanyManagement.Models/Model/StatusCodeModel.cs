using System;
using System.Collections.Generic;
using System.Text;

namespace CompanyManagement.Models.Model
{
   public class StatusCodeModel:Response
    {
        public int StatusId { get; set; }

        public string StatusDescription { get; set; }
    }
}
