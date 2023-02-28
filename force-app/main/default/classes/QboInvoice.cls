public virtual class QboInvoice extends QboAbstractDataChildObject implements IConvertible, IChildrenable{
    
    public List<QboInvoiceLine> Line {get;set;}
    
    public QboDataObject.EmailAddress BillEmail {get;set;}
    public QboDataObject.EmailAddress BillEmailCc {get;set;}
    public QboDataObject.EmailAddress BillEmailBcc {get;set;}
    
    public Date TxnDate {get;set;}
    public Date ShipDate {get;set;}
    public Date DueDate {get;set;}
    
    public QboDataObject.PhysicalAddress BillAddr {get;set;}
    public QboDataObject.PhysicalAddress ShipFromAddr {get;set;}
    
    
    public string DocNumber {get;set;}
    public string TrackingNum {get;set;}
    public string PrintStatus {get;set;}
    public string TxnSource {get;set;}
    public string GlobalTaxCalculation {get;set;}
    public string TransactionLocationType {get;set;}
    public string PrivateNote {get;set;}
    public string EmailStatus {get;set;}
    public string InvoiceLink {get;set;}
    
    public QboDataObject.ReferenceType ClassRef {get;set;}
    public QboDataObject.ReferenceType CustomerRef {get;set;}
    public QboDataObject.ReferenceType SalesTermRef {get;set;}
    public QBoDataObject.ReferenceType DepartmentRef {get;set;}
    public QBoDataObject.ReferenceType ShipMethodRef {get;set;}
    
    public boolean AllowOnlineACHPayment {get;set;}
    public boolean AllowOnlineCreditCardPayment {get;set;}
    public boolean ApplyTaxAfterDiscount {get;set;}
    public boolean FreeFormAddress {get;set;}
    

    public decimal ExchangeRate {get;set;}
    public decimal Deposit {get;set;}
    public decimal HomeBalance {get;set;}
    public long TotalAmt {get;set;}
    public decimal HomeTotalAmt {get;set;}
    public decimal Balance {get;set;}


    public  override Schema.SObjectType getSobjectType(){
        return Invoice__c.getSobjectType();
    }
    
    
    
    
    
    
    
    public Sobject convert(){
        Invoice__c invoice  = (Invoice__c)setDefaults(new Invoice__c());
        invoice.Invoice_Due_Date__c = this.DueDate;
        invoice.Message_on_Invoice__c = this.PrivateNote;
        invoice.Qb_Email__c = this.BillEmail.Address;
        invoice.Allow_Online_Ach_Payment__c = this.AllowOnlineACHPayment;
        invoice.Allow_Online_Credit_Card_Payment__c = this.AllowOnlineCreditCardPayment;
        invoice.Apply_Tax_After_Discount__c = this.ApplyTaxAfterDiscount;
        invoice.Balance__c = this.Balance;
        invoice.Currency_Ref__c = this.CustomerRef.value;
        invoice.Deposit__c = this.Deposit;
        invoice.Email_Status__c = this.EmailStatus;
        invoice.Home_Total_Amount__c = this.HomeTotalAmt;
        invoice.Total_Amount__c = this.TotalAmt;
        invoice.Tracking_Number__c = this.TrackingNum;
        invoice.Transaction_Date__c = this.TxnDate;
        invoice.Transaction_Source__c = this.TxnSource;
        invoice.Qb_Customer_Ref__c = this.CustomerRef.value;
        invoice.Doc_Number__c = this.DocNumber;
        invoice.Invoice_Link__c = this.InvoiceLink;
        invoice.FreeForm_Address__c = this.FreeFormAddress;
        
        return (Invoice__c)this.relateToParent(invoice);
    }

    
    public List<QboDataObject> getChildren(){
        List<QboDataObject> children = new List<QboDataObject>();
        children.addAll(this.Line);
        return children;
        
    }
    
}