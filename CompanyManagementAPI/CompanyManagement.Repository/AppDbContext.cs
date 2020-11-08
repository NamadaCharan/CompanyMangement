using CompanyManagement.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

namespace CompanyManagement.Repository
{
   public  class AppDbContext:DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options):base(options)
        {

        }
        public DbSet<StatusCode> Status { get; set; }
        public DbSet<CompanyDetails> CompanyDetails { get; set; }
        public DbSet<ContactDetails> ContactDetails { get; set; }
        public DbSet<Products> ProductsDetails { get; set; }
        public DbSet<ProductDetailsForChat> ProductDetailsForChats { get; set; }


    }
}
