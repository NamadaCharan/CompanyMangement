using System;
using System.Collections.Generic;
using System.Text;

namespace CompanyManagement.Models.Model
{
    public class ProductDetailsForChatModel:Response
    {
        public string ProductName { get; set; }
        public int NoOfItems { get; set; }
    }
}
