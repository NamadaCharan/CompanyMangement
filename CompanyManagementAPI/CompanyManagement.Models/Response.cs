using System;
using System.Collections.Generic;
using System.Text;

namespace CompanyManagement.Models
{
    /// <summary>
    /// Base Response Class
    /// </summary>
    public class Response
    {
        public bool IsSuccess { get; set; }
        public string Message { get; set; }
    }
}
