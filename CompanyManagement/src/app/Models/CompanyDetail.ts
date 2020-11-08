import { CompanyDetails } from 'src/app/Models/CompanyDetails';
import { ContactDetails } from 'src/app/Models/ContactDetails';

export class CompanyDetail {
    companyDetails: CompanyDetails;
    contactDetails: ContactDetails[];
    nextStatusId: number;
    nextStatusDescription: string;
    isSuccess:boolean;
    message:string;
}