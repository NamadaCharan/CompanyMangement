using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace CompanyManagement.Models
{
    [Table("tblItems")]
    public class Items
    {
        [Key]
        public int ItemId { get; set; }
        public int UserId { get; set; }
        public int ProductId { get; set; }
        public int NoOfItems { get; set; }
    }
}
