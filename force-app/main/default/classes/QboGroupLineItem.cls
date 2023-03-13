public virtual class QboGroupLineItem {
        
    // sets values peculiar to the group line item        
    public static Sobject convert(Sales_Receipt_Line_Item__c lineItem , QboGroupLineItemDetail GroupLineDetail ){
        lineItem.Qty__c = GroupLineDetail.Quantity;
        if(GroupLineDetail.Line != null && GroupLineDetail.Line.size()>0){
            lineItem.Line__c = String.join(GroupLineDetail.Line, '\n');
        }
        return lineItem;
    }
        
    public static Sobject convert(Invoice_Line_Item__c lineItem , QboGroupLineItemDetail GroupLineDetail){
        lineItem.Qty__c = GroupLineDetail.Quantity;
        if(GroupLineDetail.Line != null && GroupLineDetail.Line.size()>0){
            lineItem.Line__c = String.join(GroupLineDetail.Line, '\n');
        }
        return lineItem;
    }
    

}