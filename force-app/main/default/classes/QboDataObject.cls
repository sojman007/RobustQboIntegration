public abstract class QboDataObject {
    // qbo record Id used when we process a created event
    public string Id {get;set;}
    public string SyncToken {get;set;}

    public string sfRecordId {get;set;}

    protected virtual Sobject setDefaults(Sobject record){
        record.put('Qbo_Id__c', this.Id);
        record.put('Sync_Token__C', this.SyncToken);
        if(sfRecordId != null){
            record.put('Id', sfRecordId);
        }
        return record;
    }
    
    public virtual boolean isConvertible(){
        return this instanceof IConvertible;
        
    }
    public virtual boolean isChildrenable(){
        return this instanceof IChildrenable;
        
    }
    
    
    
    /**
     * 
     * COMMON TYPES DEFINED BELOW 
     * QDate , EmailAddress , ReferenceType , TelephoneNumber , PhysicalAddres
     * 
     * */
    
    
    public class QDate {
        public string data {get;set;}
    }

    public class QDateTime {
        //public string dateTime {get;set;}
    }
    
    public class EmailAddress{
        public string Address {get;set;}
    }
    public class ReferenceType {
        public string name {get;set;}
        public string value {get;set;}
    }
    
    public class TelephoneNumber{
        public string FreeFormNumber {get;set;}
    }
    public class ModificationMetaData{
        public Datetime CreateTime {get;set;}
        public Datetime LastUpdateTime {get;set;}
    }
    
    public class PhysicalAddress{
        public string Id {get;set;}
        public string PostalCode {get;set;}
        public string City {get;set;}
        public string Country {get;set;}
        public string Line1 {get;set;}
        public string Line2 {get;set;}
        public string Line3 {get;set;}
        public string Line4 {get;set;}
        public string Line5 {get;set;}
        public string CountrySubDivisionCode {get;set;}   
        
        public override string toString(){
            return String.join(new List<string>{Line1 , Line2 , City , Country , PostalCode}, ',');
        }
    }

    public class CreditCardPayment{
        public CreditCardChargeResponse CreditChargeResponse {get;set;}
        public CreditChargeInfo CreditChargeInfo {get;set;}
    }

    public class CreditCardChargeResponse{
        public string Status {get;set;}
        public string AuthCode {get;set;}
        public QDatetime TxnAuthorizationTime {get;set;}
        public string CCTransId {get;set;}

    }

    public class CreditChargeInfo{
        public integer CcExpiryMonth {get;set;}
        public boolean ProcessPayment {get;set;}
        public string PostalCode {get;set;}
        public double Amount {get;set;}
        public string NameOnAcct {get;set;}
        public integer CcExpiryYear {get;set;}
        public string Type {get;set;}
        public string BillAddrStreet {get;set;}

    }
    public class TxnTaxDetail {
        public ReferenceType TxnTaxCodeRef {get;set;}
        public double TotalTax {get;set;}
        public List<TaxLine> TaxLine {get;set;}

    }

    public class TaxLine {
        public string DetailType {get;set;}
        public double Amount {get;set;}
        public TaxLineDetail TaxLineDetail {get;set;}
    }
    public class TaxLineDetail {
        public ReferenceType TaxRateRef {get;set;}
        public boolean NetAmountTaxable {get;set;}
        public boolean PercentBased {get;set;}
        public double TaxInclusiveAmount {get;set;}
        public double OverrideDeltaAmount {get;set;}
        public boolean TaxPercent {get;set;}

    }
}