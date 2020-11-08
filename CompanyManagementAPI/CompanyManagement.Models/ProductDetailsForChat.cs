using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace CompanyManagement.Models
{
    public class ProductDetailsForChat
    {
        [Key]
        public string ProductName { get; set; }
        public int  NoOfItems { get; set; }
    }
}
