using AutoMapper;
using CompanyManagement.Models;
using CompanyManagement.Models.Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace CompanyManagement.Business.AutoMapper
{
    public class MappingProfile:Profile
    {
        public MappingProfile()
        {
            CreateMap<StatusCode, StatusCodeModel>()
                .ForMember(destination => destination.StatusId, maporgin =>
                   maporgin.MapFrom(src => src.StatusId))
                .ForMember(destination => destination.StatusDescription,
                maporgin => maporgin.MapFrom(src => src.StatusDescription));

            CreateMap<CompanyDetails, CompanyDetailsModel>();
            CreateMap<ContactDetailsModel, ContactDetails>();
            CreateMap<ContactDetails, ContactDetailsModel>();
            CreateMap<CompanyDetailsModel, CompanyDetails>();
            CreateMap<NewCompanyModel, CompanyDetails>();
            CreateMap<Products, ProductsModel>();
            CreateMap<ItemsModel, Items>();
            CreateMap<Items, ItemsModel>();
            CreateMap<ProductDetailsForChat, ProductDetailsForChatModel>();
        }
    }
}
