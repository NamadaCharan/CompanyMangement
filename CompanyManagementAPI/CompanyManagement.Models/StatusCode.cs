using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace CompanyManagement.Models
{
    [Table("tblStatusCode")]
   public class StatusCode
    {
        [Key]
        public int StatusId { get; set; }

        public string StatusDescription { get; set; }
    }
}
