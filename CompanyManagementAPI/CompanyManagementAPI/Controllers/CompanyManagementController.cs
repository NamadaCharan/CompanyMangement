using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CompanyManagement.Abstractions.Business;
using CompanyManagement.Models;
using CompanyManagement.Models.Model;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CompanyManagementAPI.Controllers
{
    [Produces("application/json")]
    [Route("api/[controller]")]
    [ApiController]
    public class CompanyManagementController : ControllerBase
    {
        private readonly ICompanyManagementManager _companyManagementManager;
        public CompanyManagementController(ICompanyManagementManager companyManagementManager)
        {
            _companyManagementManager = companyManagementManager;
        }

        [HttpGet]
        [Route("GetStatus")]
         public async Task<IActionResult> GetStatusCode()
         {
            var result= await _companyManagementManager.GetStatusCode();
            return Ok(result);
         }

        [HttpGet]
        [Route("CompanyDetails")]
        public async Task<IActionResult> GetCompanyDetails()
        {
            var result = await _companyManagementManager.GetCompanyDetails();
            if(result==null)
            {
                return NoContent();
            }
            return Ok(result);
        }

        [HttpGet]
        [Route("CompanyDetails/{CompanyId}")]
        public async Task<IActionResult> GetCompanyDetailsById(int? CompanyId)
        {
            if (CompanyId == null)
            {
                return BadRequest(new Response() { IsSuccess = false, Message = "Invalid Parameters" });
            }
            else
            {
                var result = await _companyManagementManager.GetCompanyDetailsById((int)CompanyId);
                if (result == null)
                {
                    return StatusCode(500, result);
                }
                else
                {
                    return Ok(result);
                }

            }

        }

        [HttpPost]
        [Route("AddUserContact")]
        public async Task<IActionResult> AddUserContact(ContactDetailsModel contactDetailsModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new Response() { Message="Invalid Parameters!.Contact Support Team",IsSuccess=false});
            }
           var result= await _companyManagementManager.AddContactDetails(contactDetailsModel);
            if (result==1)
            {
                return StatusCode(201, new Response() { Message = "User Information has been Successfully Added", IsSuccess = true });
            }

            else if(result==0)
            {
                return StatusCode(500, new Response() { Message = "Issue while proceesing the Request. Please contact the Support Team", IsSuccess = false });
            }
            else
            {
                return StatusCode(200, new Response() { Message = "Phone Number Already Exists. Please use other phone number to add the contact", IsSuccess = false });

            }
        }

        [HttpPost]
        [Route("AddComapanyDeatils")]
        public async Task<IActionResult> AddComapanyDeatils(NewCompanyModel companyDetailsModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new Response() { Message = "Invalid Parameters!.Contact Support Team", IsSuccess = false });
            }
          var result=  await _companyManagementManager.AddCompanyDetails(companyDetailsModel);
            if (result)
            {
                return StatusCode(201, new Response() { Message = "Company Details are added Successfully", IsSuccess = true });
            }
            else 
            {
                return StatusCode(500, new Response() { Message = "Issue while proceesing the Request. Please contact the Support Team", IsSuccess = false });
            }
          
        }

        [HttpPut]
        [Route("UpdateStatus")]

        public async Task<IActionResult> UpdateStatus(CompanyDetailsModel companyDetailModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new CompanyDetailModel() { Message = "Object is Not Valid", IsSuccess = false });
            }
            var result = await _companyManagementManager.UpdateStatus(companyDetailModel);
            if (result != null)
            {
                result.Message = "Status has been Successfull changed to " + result.companyDetails.StatusDescription;
                return Ok(result);
            }
            else
            {
                return StatusCode(500, new CompanyDetailModel { Message = "Internal Server Error", IsSuccess = false });
            }

        }
        
        [HttpGet]
        [Route("GetProductDetails")]
        public async Task<IActionResult> GetProductDetails()
        {
            var result = await _companyManagementManager.GetProductDetails();
            if(result!=null)
            {
                return Ok(result);
            }
            else
            {
              return   StatusCode(500, new ProductsModel { Message = "Issue while proceesing the Request. Please contact the Support Team", IsSuccess = false });
            }

        }


        [HttpPost]
        [Route("AddOrUpdateItems")]
        public async Task<IActionResult> AddOrUpdateItems(ItemsModel items)
        {
            var result = await _companyManagementManager.AddOrUpdateItems(items);
            if (result)
            {
                return Ok(new Response (){ Message = "Products Added Successfully", IsSuccess = true });
            }
            else
            {
                return StatusCode(500, new Response { Message = "Issue while proceesing the Request. Please contact the Support Team", IsSuccess = false });
            }

        }


        [HttpGet]
        [Route("GetProductDetailsForChat/{companyId}")]
        public async Task<IActionResult> GetProductDetailsForChat(int companyId)
        {
            var result = await _companyManagementManager.ProductDetailsForChats(companyId);
            if (result != null)
            {
                
                
                return Ok(result);
            }
            else
            {
                return StatusCode(500, new ProductDetailsForChatModel { Message = "Issue while proceesing the Request. Please contact the Support Team", IsSuccess = false });
            }

        }

    }
}