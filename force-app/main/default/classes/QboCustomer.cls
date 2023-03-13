public class QboCustomer extends QBoDataObject implements IConvertible {
    
    public string DisplayName {get;set;}
    public string Title {get;set;}
    public string GivenName {get;set;}
    public string MiddleName {get;set;}
    public string Suffix {get;set;}
    public string FamilyName {get;set;}
    public string ResaleNum {get;set;}
    public string PreferredDeliveryMethod {get;set;}
    public string Notes {get;set;}
    public string FullyQualifiedName {get;set;}
    public string Balance {get;set;}
    public string BalanceWithJobs {get;set;}
    public string BusinessNumber {get;set;}
    public string PrimaryTaxIdentifier {get;set;}
    public string CompanyName {get;set;}
    
    public QBoDataObject.EmailAddress PrimaryEmailAddr {get;set;}
   
    public QBoDataObject.TelephoneNumber Mobile {get;set;}
    public QboDataObject.TelephoneNumber AlternatePhone {get;set;}
    public QboDataObject.TelephoneNumber PrimaryPhone {get;set;}
    
    public boolean Taxable {get;set;}
    
    public QboDataObject.ReferenceType ParentRef {get;set;}    
    
    public integer Level {get;set;}
    
    
    public QboDataObject.PhysicalAddress ShipAddr {get;set;}
    public QboDataObject.PhysicalAddress BillAddr {get;set;}
   

    public override string getDTOClassName(){
        return 'QboCustomer';
    }

    
    public  Sobject convert(){
        
        Account customer = (Account)setDefaults(new Account());
        customer.Name = this.DisplayName;
        customer.Electronic_Invoice_Email_Address__c = PrimaryEmailAddr.Address;
        customer.Customer_QB_Id__c = this.Id;
        customer.Customer_QB_Name__c = this.FullyQualifiedName;
        customer.Notes__c = this.Notes;
        customer.ShippingCity = ShipAddr.City;
        customer.ShippingCountry = ShipAddr.Country;
        customer.ShippingState = ShipAddr.CountrySubDivisionCode;
        customer.ShippingStreet = ShipAddr.Line1;
        customer.ShippingPostalCode = ShipAddr.PostalCode;
        
        customer.BillingCity = BillAddr.City;
        customer.BillingCountry = BillAddr.Country;
        customer.BillingState = BillAddr.CountrySubDivisionCode;
        customer.BillingStreet = BillAddr.Line1;
        customer.BillingPostalCode = BillAddr.PostalCode;
        
        
        customer.AccountNumber = this.BusinessNumber;
        customer.Balance__c = Decimal.valueOf(this.Balance);
        customer.Balance_With_Jobs__c = Decimal.valueOf(this.BalanceWithjobs);
        customer.Sync_Token__c = this.SyncToken;
        customer.Primary_Tax_Identifier__c = this.PrimaryTaxIdentifier;
        customer.Taxable__c = this.Taxable;
        customer.Company_Name__c = this.CompanyName;
        
        return customer;
    }
    
}