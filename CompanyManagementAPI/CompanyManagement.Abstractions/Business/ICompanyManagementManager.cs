using CompanyManagement.Models;
using CompanyManagement.Models.Model;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace CompanyManagement.Abstractions.Business
{
    public interface ICompanyManagementManager
    {
        Task<List<StatusCodeModel>> GetStatusCode();
        Task<List<CompanyDetailsModel>> GetCompanyDetails();
        Task<CompanyDetailModel> GetCompanyDetailsById(int CompanyId);
        Task<int> AddContactDetails(ContactDetailsModel contactDetails);
        Task<bool> AddCompanyDetails(NewCompanyModel companyDetails);
        Task<CompanyDetailModel> UpdateStatus(CompanyDetailsModel companyDetails);

        Task<List<ProductsModel>> GetProductDetails();
        Task<bool> AddOrUpdateItems(ItemsModel items);
        Task<List<ProductDetailsForChatModel>> ProductDetailsForChats(int companyId);

    }
}
