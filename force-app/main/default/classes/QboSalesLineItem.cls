public virtual class QboSalesLineItem {
    
    public static Sobject convert(Sales_Receipt_Line_Item__c lineItem, QboSalesLineItemDetail SalesItemLineDetail){
        
        lineItem.Tax_Inclusive_Amount__c = SalesItemLineDetail.TaxInclusiveAmt;
        lineItem.Service_Date__c = SalesItemLineDetail.ServiceDate;
        lineItem.Discount_Rate__c = SalesItemLineDetail.DiscountRate;
        lineItem.Qty__c = SalesItemLineDetail.Qty;
        lineItem.Unit_Price__c = SalesItemLineDetail.UnitPrice;
        lineItem.Discount_Amount__c = SalesItemLineDetail.DiscountAmt;
        return lineItem;
    }

    public static Sobject convert(Invoice_Line_Item__c lineItem , QboSalesLineItemDetail SalesItemLineDetail){
        
        lineItem.Tax_Inclusive_Amount__c = SalesItemLineDetail.TaxInclusiveAmt;
        lineItem.Service_Date__c = SalesItemLineDetail.ServiceDate;
        lineItem.Discount_Rate__c = SalesItemLineDetail.DiscountRate;
        lineItem.Qty__c = SalesItemLineDetail.Qty;
        lineItem.Unit_Price__c = SalesItemLineDetail.UnitPrice;
        lineItem.Discount_Amount__c = SalesItemLineDetail.DiscountAmt;
        return lineItem;
    }

 
 
     



}