using System;
using System.Collections.Generic;
using System.Text;

namespace CompanyManagement.Models.Model
{
   public enum StatusCodesEnums
    {
        Sales_Lead=1,
        Sales_Opportunity,
        Dead_End,
        Initial_discussion,
        Proposal,
        Negotiation,
        Deal_Won,
        Deal_Lost
    }
}
