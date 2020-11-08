using CompanyManagement.Abstractions.Repository;
using CompanyManagement.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace CompanyManagement.Repository
{
    public class CompanyManagementRepository : ICompanyManagementRepository
    {
        private readonly AppDbContext _companyManagementRepository;
        public CompanyManagementRepository(AppDbContext companyManagementRepository)
        {
            _companyManagementRepository = companyManagementRepository;
        }



        public async  Task<List<StatusCode>> GetStatusCode()
        {
            try
            {
                return await _companyManagementRepository.Status.FromSql<StatusCode>("prcGetStatusCode").ToListAsync();
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public async Task<List<CompanyDetails>> GetCompanyDetails()
        {
            try
            {
                return await _companyManagementRepository.CompanyDetails.FromSql<CompanyDetails>("prcSelCompanyDetails").ToListAsync();
            }
            catch(Exception ex)
            {
                return null;
            }
        }

        public async Task<CompanyDetails> GetCompanyDetailsById(int CompanyId)
        {
            try
            {
               var result=( await _companyManagementRepository.CompanyDetails.FromSql<CompanyDetails>("prcSelCompanyDetails {0}", CompanyId).ToListAsync()).FirstOrDefault();
                return result;
            }
            catch(Exception ex)
            {
                return null;
            }
        }

        public async Task<bool> AddContactDetails(ContactDetails contactDetails)
        {
            try
            {
                //  var result = _companyManagementRepository.ContactDetails.FromSql("prcAdduserContactDetails {0},{1},{2},{3},{4}", contactDetails.FullName, contactDetails.Email, contactDetails.Mobile, contactDetails.GenderId, contactDetails.CompanyId);
                _companyManagementRepository.ContactDetails.Add(contactDetails);
                await _companyManagementRepository.SaveChangesAsync();
                return true;
            }
            catch(Exception ex)
            {
                return false;
            }

        }

        public async Task<bool> AddCompanyDetails(CompanyDetails companyDetails)
        {
            try
            {
                _companyManagementRepository.CompanyDetails.Add(companyDetails);
                await _companyManagementRepository.SaveChangesAsync();
                return true;

            }
            catch(Exception ex)
            {
                return false;
            }
        }


        public async Task<bool> UpdateStatus(CompanyDetails companyDetails)
        {
            try
            {
                var result = await _companyManagementRepository.Database.ExecuteSqlCommandAsync("prcUpdateStatusCode {0},{1}", companyDetails.CompanyId, companyDetails.StatusId);
                return true;
            }
            catch(Exception ex)
            {
                return false;
            }
        }


        public async Task<List<ContactDetails>> GetContactDetailsByCompany(int companyId)
        {
            try
            {
                return await _companyManagementRepository.ContactDetails.FromSql<ContactDetails>("prcGetContactDetailsById {0}", companyId).ToListAsync();
                
            }
            catch(Exception ex)
            {
                return null;
            }
        }

        public async Task<List<Products>> GetProductDetails()
        {
            try
            {
                return await _companyManagementRepository.ProductsDetails.FromSql<Products>("prcGetProductDetails").ToListAsync();

            }
            catch(Exception ex)
            {
                return null;
            }
        }

        public async Task<bool> AddOrUpdateItems(Items items)
        {
            try
            {
                await _companyManagementRepository.Database.ExecuteSqlCommandAsync("prcAddorUpdateProductItems {0},{1},{2}", items.UserId, items.ProductId, items.NoOfItems);
                return true;
            }
            catch(Exception ex)
            {
                return false;
            }
        }


        public async Task<List<ProductDetailsForChat>> ProductDetailsForChats(int companyId)
        {
            try
            {
             return    await _companyManagementRepository.ProductDetailsForChats.FromSql<ProductDetailsForChat>("prcGetProductDetailsForChats {0}", companyId).ToListAsync();
               
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public async Task<List<ContactDetails>> CheckDuplicateByphone(int companyId, string phoneNumber)
        {
          
            try
            {
                return await _companyManagementRepository.ContactDetails.FromSql<ContactDetails>("prcCheckDuplicateForCompanyPhone {0},{1}", companyId,phoneNumber).ToListAsync();

            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}
