public virtual class QboDiscountLineItem {
        
    public static Sobject convert(Sales_Receipt_Line_Item__c lineItem , QboDiscountLineDetail DiscountLineDetail){
        lineItem.Tax_Code_Reference__c = DiscountLineDetail.TaxCodeRef.value;
        lineItem.Discount_Account_Reference__C = DiscountLineDetail.DiscountAccountRef.value;
        lineItem.Percent_Based__c = DiscountLineDetail.PercentBased;
        lineItem.Discount_Percent__c = DiscountLineDetail.DiscountPercent;
        return lineItem;
    }
   
        
    public static Sobject convert(Invoice_Line_Item__c lineItem , QboDiscountLineDetail DiscountLineDetail){
        lineItem.Tax_Code_Reference__c = DiscountLineDetail.TaxCodeRef.value;
        lineItem.Discount_Account_Reference__C = DiscountLineDetail.DiscountAccountRef.value;
        lineItem.Percent_Based__c = DiscountLineDetail.PercentBased;
        lineItem.Discount_Percent__c = DiscountLineDetail.DiscountPercent;
        return lineItem;
    }
    
    
    
}