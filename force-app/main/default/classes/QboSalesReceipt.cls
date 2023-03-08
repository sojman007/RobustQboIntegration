public class QboSalesReceipt extends QboAbstractDataChildObject implements IConvertible, IChildrenable {
    
    public List<QboSalesLine> Line {get;set;}
    
    public QboDataObject.EmailAddress BillEmailCc {get;set;}
    public QboDataObject.EmailAddress BillEmail {get;set;}
    public QboDataObject.EmailAddress BillEmailBcc {get;set;}
    
    public QbodataObject.TxnTaxDetail TxnTaxDetail {get;set;}
    public QboDataObject.CreditCardPayment CreditCardPayment {get;set;}
    
    
    public Date TxnDate {get;set;}
    public Date DueDate {get;set;}
    public Date ShipDate {get;set;}
    
    
    public QboDataObject.ReferenceType ClassRef {get;set;}
    public QboDataObject.ReferenceType CustomerRef {get;set;}
    public QboDataObject.ReferenceType CurrencyRef {get;set;}
    public QBoDataObject.ReferenceType DepositToAccountRef {get;set;}
    public QboDataObject.ReferenceType SalesTermRef {get;set;}
    public QboDataObject.ReferenceType ShipMethodRef {get;set;}
    public QboDataObject.ReferenceType RecurDataRef {get;set;}
    public QBoDataObject.ReferenceType DepartmentRef {get;set;}
   
    
    public string TrackingNum {get;set;}
    public string PrintStatus {get;set;}
    public string DocNumber {get;set;}
    public string TxnSource {get;set;}
    public string GlobalTaxCalculation {get;set;}
    public string TransactionLocationType {get;set;}
    public string PrivateNote {get;set;}
    public string PaymentRefNum {get;set;}
    public string EmailStatus {get;set;}
    public string salesReceiptLink {get;set;}
    
    
    public boolean FreeFormAddress {get;set;}
    public boolean AllowOnlineACHPayment {get;set;}
    public boolean AllowOnlineCreditCardPayment {get;set;}
    public boolean ApplyTaxAfterDiscount {get;set;}
    
    public double ExchangeRate {get;set;}
    public double Deposit {get;set;}
    public double TotalAmt {get;set;}
    public double HomeTotalAmt {get;set;}
    public double Balance {get;set;}
    public double HomeBalance {get;set;}
    public double Amount {get;set;}
    public double TotalTax {get;set;}
    
    public QboDataObject.PhysicalAddress BillAddr {get;set;}
    public QboDataObject.PhysicalAddress ShipAddr {get;set;}
    public QboDataObject.PhysicalAddress ShipFromAddr {get;set;}


    
    public  override Schema.SObjectType getSobjectType(){
        return Sales_Receipt__c.getSobjectType();
    }
    
    
    
    
    
    
    
    public Sobject convert(){
        Sales_Receipt__c salesReceipt  = (Sales_Receipt__c)setDefaults(new Sales_Receipt__c());
        salesReceipt.Qbo_id__c = this.Id;
        salesReceipt.Customer_Ref__c = this.CustomerRef.value;
        salesReceipt.Doc_Number__c = this.DocNumber;
        salesReceipt.Sync_Token__c = this.SyncToken;
        salesReceipt.Currency_Ref__c = this.CurrencyRef.value;
        salesReceipt.Bill_Email_Address__c = this.BillEmail.Address;
        salesReceipt.Txn_Date__c = this.TxnDate;
        salesReceipt.Ship_From_Address__c = this.ShipFromAddr.toString();
        salesReceipt.Ship_Address__c = this.ShipAddr.toString();
        salesReceipt.Amount__c = this.Amount;
        salesReceipt.Ship_Date__c = this.ShipDate;
        salesReceipt.Tracking_Number__c = this.TrackingNum;
        salesReceipt.Payment_Ref_Number__c = this.PaymentRefNum;
        salesReceipt.Global_Tax_Calculation__c = this.GlobalTaxCalculation;
        salesReceipt.Apply_Tax_After_Discount__c = this.ApplyTaxAfterDiscount;
        salesReceipt.Private_Notes__c = this.PrivateNote;
        salesReceipt.Total_Tax__c = this.TotalTax;
        salesReceipt.Bill_Address__c = this.BillAddr.toString();
        salesReceipt.Home_Balance__c = this.HomeBalance;
        salesReceipt.Total_Amt__c = this.TotalAmt;
        salesReceipt.Balance__c = this.Balance;
        salesReceipt.Home_Total_Amount__c = this.HomeTotalAmt;
        salesReceipt.Free_Form_Address__c = this.FreeFormAddress;

        return (Sales_Receipt__c)this.relateToParent(salesReceipt);
    }

    
    public List<QboDataObject> getChildren(){
        List<QboDataObject> children = new List<QboDataObject>();
        children.addAll(this.Line);
        return children;
        
    }
    
}