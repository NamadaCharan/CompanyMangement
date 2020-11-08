using CompanyManagement.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace CompanyManagement.Abstractions.Repository
{
    public interface ICompanyManagementRepository
    {
        Task<List<StatusCode>> GetStatusCode();
        Task<List<CompanyDetails>> GetCompanyDetails();
        Task<CompanyDetails> GetCompanyDetailsById(int CompanyId);
        Task<bool> AddContactDetails(ContactDetails contactDetails);
        Task<bool> AddCompanyDetails(CompanyDetails companyDetails);
        Task<bool> UpdateStatus(CompanyDetails companyDetails);
        Task<List<ContactDetails>> GetContactDetailsByCompany(int companyId);
        Task<List<Products>> GetProductDetails();
        Task<bool> AddOrUpdateItems(Items items);
        Task<List<ProductDetailsForChat>> ProductDetailsForChats(int companyId);
        Task<List<ContactDetails>> CheckDuplicateByphone(int companyId,string phoneNumber);
    }
}
