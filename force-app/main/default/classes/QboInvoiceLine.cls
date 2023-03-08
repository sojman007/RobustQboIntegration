/**
 * 
 * Represents abstraction for Qbo invoice line items 
 * 
 * */
public abstract class QboInvoiceLine extends QboAbstractDataChildObject{
    
    public string Id {get;set;}
    public string DetailType {get;set;}
    public string Description {get;set;}
    
    public decimal LineNum {get;set;}
    
    public override Schema.SobjectType getSobjectType(){
        return Invoice_Line_Item__c.getSobjectType();
    }
    
    protected Sobject convertBase(){
        Invoice_Line_Item__c lineItem = new Invoice_Line_Item__c();
        lineItem.DetailType__c = this.DetailType;
        lineItem.Line_Number__c = this.LineNum;
        
        return (Invoice_Line_Item__c)this.relateToParent(lineItem);
    }
    
    public virtual class QboSalesLineItem extends QboInvoiceLine  implements IConvertible{
       
        public QboSalesLineItemDetail  SalesItemLineDetail {get;set;}
        public double Amount {get;set;}

        // sets values appropriate to the the sales line item
        public Sobject convert(){
            Invoice_Line_Item__c lineItem = (Invoice_Line_Item__c)setDefaults(convertBase());
            lineItem.Amount__c = this.Amount;
            lineItem.Tax_Inclusive_Amount__c = this.SalesItemLineDetail.TaxInclusiveAmt;
            lineItem.Service_Date__c = this.SalesItemLineDetail.ServiceDate;
            lineItem.Discount_Rate__c = this.SalesItemLineDetail.DiscountRate;
            lineItem.Qty__c = this.SalesItemLineDetail.Qty;
            lineItem.Unit_Price__c = this.SalesItemLineDetail.UnitPrice;
            lineItem.Discount_Amount__c = this.SalesItemLineDetail.DiscountAmt;
            return lineItem;
        }



    }
    
    public virtual class QboGroupLineItem extends QboInvoiceLine  implements IConvertible{
        public QboGroupLineItemDetail GroupLineDetail {get;set;}
        
        // sets values peculiar to the group line item        
        public Sobject convert(){
            Invoice_Line_Item__c lineItem = (Invoice_Line_Item__c)setDefaults(convertBase());
            lineItem.Qty__c = this.GroupLineDetail.Quantity;
            if(this.GroupLineDetail.Line != null && this.GroupLineDetail.Line.size()>0){
                lineItem.Line__c = String.join(this.GroupLineDetail.Line, '\n');
            }
            return lineItem;
        }
        
	}
    
    public virtual class QboDescriptionOnlyLineItem extends QboInvoiceLine  implements IConvertible{
        public QboDescriptionOnlyLineDetail DescriptionLineDetail {get;set;}
        
        // sets values peculiar to the description only line item
        public Sobject convert(){
            Invoice_Line_Item__c lineItem = (Invoice_Line_Item__c)setDefaults(convertBase());
            lineItem.Tax_Code_Reference__c = this.DescriptionLineDetail.TaxCodeRef.value;
            lineItem.Service_Date__c = this.DescriptionLineDetail.ServiceDate;
            return lineItem;
        }
        
    }
    
    public virtual class QboDiscountLineItem extends QboInvoiceLine  implements IConvertible{
        public QboDiscountLineDetail DiscountLineDetail {get;set;}
        
        public Sobject convert(){
            Invoice_Line_Item__c lineItem = (Invoice_Line_Item__c)setDefaults(convertBase());
            lineItem.Tax_Code_Reference__c = this.DiscountLineDetail.TaxCodeRef.value;
            lineItem.Discount_Account_Reference__C = this.DiscountLineDetail.DiscountAccountRef.value;
            lineItem.Percent_Based__c = this.DiscountLineDetail.PercentBased;
            lineItem.Discount_Percent__c = this.DiscountLineDetail.DiscountPercent;
            return lineItem;
        }
        
    }
    
    public virtual class QboSubTotalLineItem extends QboInvoiceLine implements IConvertible{
        
        public QboSubTotalLineDetail SubtotalLineDetail {get;set;}        
        
        
        public Sobject convert(){
            Invoice_Line_Item__c lineItem = (Invoice_Line_Item__c)setDefaults(convertBase());
            lineItem.Item_Reference__c = this.SubtotalLineDetail.ItemRef.value;
            return lineItem;
        }
    
    
    }

    
    
    
    /**
     * Detail Classes Listed Below.
     * Depending on what LineItemDetail Type the json is converted to, the apropriate Convert method executes and extracts data from either of these detail classes below
    */
    
    public virtual class QboSubTotalLineDetail{
        public QboDataObject.ReferenceType ItemRef {get;set;}        
    }
    
    public virtual class QboDiscountLineDetail {
        public QboDataObject.ReferenceType ClassRef {get;set;}
        public QboDataObject.ReferenceType TaxCodeRef {get;set;}
        public QboDataObject.ReferenceType DiscountAccountRef {get;set;}
        
        public boolean PercentBased {get;set;}
        public decimal DiscountPercent {get;set;}
        
        
    }
    
    public virtual class QboGroupLineItemDetail {
        public decimal Quantity {get;set;}
        public List<CommonLine> Line {get;set;}
    }
    
    public virtual class CommonLine {
        public string Id {get;set;}
        
    }
    
    
    
    // sales line item detail used in the QboSalesLineItem
    public virtual class QboSalesLineItemDetail{
        
        public double TaxInclusiveAmt {get;set;}
        public double DiscountAmt {get;set;}
        public double DiscountRate {get;set;}
        public double Qty {get;set;}
        public double UnitPrice {get;set;}
        public Date ServiceDate {get;set;}
    }
    
    public virtual class QboDescriptionOnlyLineDetail {
        
        public QboDataObject.ReferenceType TaxCodeRef {get;set;}
        public Date ServiceDate {get;set;}
        
    }
    
    

}