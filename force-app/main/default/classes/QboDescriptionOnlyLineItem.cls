public virtual class QboDescriptionOnlyLineItem{
        
  public static Sobject convert(Sales_Receipt_Line_Item__c lineItem , QboDescriptionOnlyLineDetail DescriptionLineDetail){
        lineItem.Tax_Code_Reference__c = DescriptionLineDetail.TaxCodeRef.value;
        lineItem.Service_Date__c = DescriptionLineDetail.ServiceDate;
        return lineItem;
    }
    public static Sobject convert(Invoice_Line_Item__c lineItem , QboDescriptionOnlyLineDetail DescriptionLineDetail){
        lineItem.Tax_Code_Reference__c = DescriptionLineDetail.TaxCodeRef.value;
        lineItem.Service_Date__c = DescriptionLineDetail.ServiceDate;
        return lineItem;
    }
    

}