using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace CompanyManagement.Models.Model
{
    public class ContactDetailsModel
    {
        public int UserId { get; set; }
        [Required]
        public string FullName { get; set; }

        public string Email { get; set; }
        [Required]
        [MinLength(8)]
        public string Mobile { get; set; }
        public int GenderId { get; set; }
        public int CompanyId { get; set; }
    }
}
