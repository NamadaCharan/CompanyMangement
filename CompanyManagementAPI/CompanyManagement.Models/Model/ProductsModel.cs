using System;
using System.Collections.Generic;
using System.Text;

namespace CompanyManagement.Models.Model
{
    public class ProductsModel:Response
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public Decimal ProductCost { get; set; }
    }
}
