using AutoMapper;
using CompanyManagement.Abstractions.Business;
using CompanyManagement.Abstractions.Repository;
using CompanyManagement.Models;
using CompanyManagement.Models.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompanyManagement.Business
{
    public class CompanyManagementManager : ICompanyManagementManager
    {

        private readonly ICompanyManagementRepository _companyManagementRepository;

        private readonly IMapper _mapper;
        public CompanyManagementManager(ICompanyManagementRepository companyManagementRepository,IMapper mapper)
        {
            _companyManagementRepository = companyManagementRepository;
            _mapper = mapper;
        }

        public async  Task<bool> AddCompanyDetails(NewCompanyModel companyDetails)
        {
            //var result = await _companyManagementRepository.CheckDuplicateByName(companyDetails.CompanyName);
            //if (result.Count >= 1)
            //{
            //    return -1;
            //}
            var mappedObject = _mapper.Map<CompanyDetails>(companyDetails);
            mappedObject.StatusId = 1;
            return await _companyManagementRepository.AddCompanyDetails(mappedObject);
      
        }



        public async Task<int> AddContactDetails(ContactDetailsModel contactDetails)
        {
            var result = await _companyManagementRepository.CheckDuplicateByphone(contactDetails.CompanyId,contactDetails.Mobile);
            if (result.Count >= 1)
            {
                return -1;
            }
            var mappedObject = _mapper.Map<ContactDetails>(contactDetails);
           if( await _companyManagementRepository.AddContactDetails(mappedObject))
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        public async Task<bool> AddOrUpdateItems(ItemsModel items)
        {
            var mappedObject=_mapper.Map<Items>(items);
            return await _companyManagementRepository.AddOrUpdateItems(mappedObject);
        }

        public async Task<List<CompanyDetailsModel>> GetCompanyDetails()
        {
            List<CompanyDetailsModel> companyDetails = new List<CompanyDetailsModel>();
            var result = await _companyManagementRepository.GetCompanyDetails();
            var statusCode = await _companyManagementRepository.GetStatusCode();
            var DataSets = (from r in result
                            join
            s in statusCode on r.StatusId equals s.StatusId
                            select new {
                            r.Address,r.City,r.CompanyId,r.CompanyName,r.State,r.StatusId,s.StatusDescription}).ToList();
            if (DataSets != null)
            {
                DataSets.ForEach(res =>
                {
                    CompanyDetailsModel mapped = new CompanyDetailsModel();
                    mapped.CompanyId = res.CompanyId;
                    mapped.CompanyName = res.CompanyName;
                    mapped.City = res.City;
                    mapped.Address = res.Address;
                    mapped.StatusId = res.StatusId;
                    mapped.StatusDescription = res.StatusDescription;
                    mapped.State = res.State;


                    companyDetails.Add(mapped);
                });
                return companyDetails;
            }
            return null;
        }

        public async Task<CompanyDetailModel> GetCompanyDetailsById(int CompanyId)
        {
            var result = await CompanyDetailById(CompanyId);

            //  return result != null ? result : null;
            if (result != null)
            {
                return result;

            }
            return null;
        }

        public async  Task<List<ProductsModel>> GetProductDetails()
        {
            var result =await  _companyManagementRepository.GetProductDetails();
            if(result!=null)
            {
                List<ProductsModel> productsModels = new List<ProductsModel>();
                result.ForEach(response =>
                {
                    var mappedObject = _mapper.Map<ProductsModel>(response);
                    productsModels.Add(mappedObject);
                    

                });
                return productsModels;
            }
            return null;
        }

        public async Task<List<StatusCodeModel>> GetStatusCode()
        {
            List<StatusCodeModel> statusCodeModels = new List<StatusCodeModel>();
            var result = await _companyManagementRepository.GetStatusCode();
            result.ForEach(res =>
            {
                var mappedStatusCode = _mapper.Map<StatusCodeModel>(res);
                statusCodeModels.Add(mappedStatusCode);
            });

            return statusCodeModels;


        }

        public async Task<List<ProductDetailsForChatModel>> ProductDetailsForChats(int companyId)
        {
            List<ProductDetailsForChatModel> productDetailsForChatModels = new List<ProductDetailsForChatModel>();
            var result = await _companyManagementRepository.ProductDetailsForChats(companyId);
            result.ForEach(res =>
            {

               var mappedObject= _mapper.Map<ProductDetailsForChatModel>(res);
                productDetailsForChatModels.Add(mappedObject);
            });
            return productDetailsForChatModels;
        }

        public async Task<CompanyDetailModel> UpdateStatus(CompanyDetailsModel companyDetails)
        {
            var mappedObject = _mapper.Map<CompanyDetails>(companyDetails);
            bool result = await _companyManagementRepository.UpdateStatus(mappedObject);
            if (result)
            {
                var company = await CompanyDetailById(companyDetails.CompanyId);

                //  return result != null ? result : null;
                if (company != null)
                {
                    return company;

                }
                return null;

            }
            else
            {
                return null;
            }
        }


        private async  Task< CompanyDetailModel> CompanyDetailById(int companyId)
        {

            CompanyDetailModel companyDetailModel = new CompanyDetailModel();
            var result = await _companyManagementRepository.GetCompanyDetailsById(companyId);
            var statusCode = await _companyManagementRepository.GetStatusCode();
            var contactDetails = await _companyManagementRepository.GetContactDetailsByCompany(companyId);

            if (result != null)
            {
                var mappedObject = _mapper.Map<CompanyDetailsModel>(result);
                foreach (var status in statusCode)
                {
                    if (mappedObject.StatusId == status.StatusId)
                    {
                        mappedObject.StatusDescription = status.StatusDescription;
                    }
                }
                foreach (var contactDetail in contactDetails)
                {
                    ContactDetailsModel contact = new ContactDetailsModel();
                    ContactDetailsModel mappedContactDetails = _mapper.Map<ContactDetailsModel>(contactDetail);
                    contact.CompanyId = mappedContactDetails.CompanyId;
                    contact.Email = mappedContactDetails.Email;
                    contact.FullName = mappedContactDetails.FullName;
                    contact.Mobile = mappedContactDetails.Mobile;
                    contact.GenderId = mappedContactDetails.GenderId;
                    contact.UserId = mappedContactDetails.UserId;
                    companyDetailModel.contactDetails.Add(contact);


                }
                companyDetailModel.companyDetails = mappedObject;
                int currentStatusId = companyDetailModel.companyDetails.StatusId;
                int nextStatusId = companyDetailModel.companyDetails.StatusId;
                string nextStatusDescription = companyDetailModel.companyDetails.StatusDescription;
                SetNextStatusCode(ref currentStatusId, ref nextStatusId, ref nextStatusDescription);
                companyDetailModel.NextStatusDescription = nextStatusDescription;
                companyDetailModel.NextStatusId = nextStatusId;
                companyDetailModel.IsSuccess = true;

              

            }
            return companyDetailModel;

        }

        private void SetNextStatusCode(ref int currentStatusId, ref int nextStatusId, ref string NextStatusDescription)
        {
            switch (currentStatusId)
            {
                case (int)StatusCodesEnums.Sales_Lead:
                    NextStatusDescription = "Sales Opportunity";
                    nextStatusId = 2;
                    break;

                case (int)StatusCodesEnums.Sales_Opportunity:
                    NextStatusDescription = "Initial discussion";
                    nextStatusId = 4;
                    break;
                case (int)StatusCodesEnums.Initial_discussion:
                    NextStatusDescription = "Proposal";
                    nextStatusId = 5;
                    break;
                case (int)StatusCodesEnums.Proposal:
                    NextStatusDescription = "Negotiation";
                    nextStatusId = 6;
                    break;
                case (int)StatusCodesEnums.Deal_Won:
                    NextStatusDescription = "Deal_Won";
                    nextStatusId = 7;
                    break;
                case (int)StatusCodesEnums.Deal_Lost:
                    NextStatusDescription = "Deal_Lost";
                    nextStatusId = 8;
                    break;

                case (int)StatusCodesEnums.Dead_End:
                    NextStatusDescription = "Dead End";
                    nextStatusId = 3;
                    break;
            }

        }
    }
}
