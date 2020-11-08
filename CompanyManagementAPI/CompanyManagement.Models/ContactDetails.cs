using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace CompanyManagement.Models
{
    [Table("tblContactDetails")]
    public class ContactDetails
    {
        [Key]
  
        public int UserId { get; set; }
        public string FullName  { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public int GenderId { get; set; }
        public int CompanyId { get; set; }

    }
}
