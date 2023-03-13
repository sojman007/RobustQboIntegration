public virtual class QboSubTotalLineItem {
    public static Sobject convert(Sales_Receipt_Line_Item__c lineItem , QboSubTotalLineDetail SubtotalLineDetail){
        lineItem.Item_Reference__c = SubtotalLineDetail?.ItemRef?.value;
        return lineItem;
    }

    public  static Sobject convert(Invoice_Line_Item__c lineItem , QboSubTotalLineDetail SubtotalLineDetail){
        lineItem.Item_Reference__c = SubtotalLineDetail?.ItemRef?.value;
        return lineItem;
    }



}