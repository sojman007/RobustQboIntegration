/**
 * 
 * Represents abstraction for Qbo invoice line items 
 * 
 * */
public virtual class QboSalesLine extends QboAbstractDataChildObject implements IConvertible{
    
    public string Id {get;set;}
    public string DetailType {get;set;}
    public string Description {get;set;}
    public decimal LineNum {get;set;}
    public double Amount {get;set;}

    
    public QboSalesLineItemDetail  SalesItemLineDetail {get;set;}
    public QboGroupLineItemDetail GroupLineDetail {get;set;}
    public QboDescriptionOnlyLineDetail DescriptionLineDetail {get;set;}
    public QboDiscountLineDetail DiscountLineDetail {get;set;}
    public QboSubTotalLineDetail SubtotalLineDetail {get;set;}        
    
    

    public virtual override string getDTOClassName(){
        return 'QboSalesLineBase';
    }
    
    public override Schema.SobjectType getSobjectType(){
        return Sales_Receipt_Line_Item__c.getSobjectType();
    }
    
    public Sobject convert(){
        Sales_Receipt_Line_Item__c lineItem = initialize();
        
        
        switch on this.DetailType{
            when 'SalesLineItem' {
                lineItem = (Sales_Receipt_Line_Item__c)QboSalesLineItem.convert(lineItem, this.SalesItemLineDetail);
            }
            when'GroupLine'{
                lineItem = (Sales_Receipt_Line_Item__c)QboGroupLineItem.convert(lineItem,this.GroupLineDetail);
            }

            when 'DescriptionOnlyLine'{
                lineItem = (Sales_Receipt_Line_Item__c)QboDescriptionOnlyLineItem.convert(lineItem , this.DescriptionLineDetail);
            }
            when'DiscountLine'{
                lineItem = (Sales_Receipt_Line_Item__c)QboDiscountLineItem.convert(lineItem , this.DiscountLineDetail);
            }
            // subtotal line
            when else{
                lineItem = (Sales_Receipt_Line_Item__c)QboSubTotalLineItem.convert(lineItem, this.SubtotalLineDetail);
            }
        }

        return lineItem;


    }
    protected Sales_Receipt_Line_Item__c initialize(){
        Sales_Receipt_Line_Item__c lineItem = new Sales_Receipt_Line_Item__c();
        lineItem.Detail_Type__c = this.DetailType;
        lineItem.Line_Number__c = this.LineNum;
        
        return (Sales_Receipt_Line_Item__c)this.relateToParent(lineItem);
    }
    

}