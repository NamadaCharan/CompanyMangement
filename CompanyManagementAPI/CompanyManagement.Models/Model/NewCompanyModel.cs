﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace CompanyManagement.Models.Model
{
   public class NewCompanyModel
    {

        [Required]
        public string CompanyName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public int StatusId { get; set; }
    }
}
