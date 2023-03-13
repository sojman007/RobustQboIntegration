/**
 * 
 * Since this class is the parseType specified in the JSON handler, it is impossible to
 * Dynamically parse into it's subclasses. 
 * My workaround here is to then include everything from the subclasses and 
 * expose the individual convert methods as statics
 * 
 * */
public virtual class QboInvoiceLine extends QboAbstractDataChildObject implements IConvertible{
    
    // Common fields
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
    
    
    public Sobject convert(){
        Invoice_Line_Item__c lineItem = initialize();
        
        
        switch on this.DetailType{
            when 'SalesLineItem' {
                lineItem = (Invoice_Line_Item__c)QboSalesLineItem.convert(lineItem, this.SalesItemLineDetail);
            }
            when'GroupLine'{
                lineItem = (Invoice_Line_Item__c)QboGroupLineItem.convert(lineItem,this.GroupLineDetail);
            }

            when 'DescriptionOnlyLine'{
                lineItem = (Invoice_Line_Item__c)QboDescriptionOnlyLineItem.convert(lineItem , this.DescriptionLineDetail);
            }
            when'DiscountLine'{
                lineItem = (Invoice_Line_Item__c)QboDiscountLineItem.convert(lineItem , this.DiscountLineDetail);
            }
            // subtotal line
            when else{
                lineItem = (Invoice_Line_Item__c)QboSubTotalLineItem.convert(lineItem, this.SubtotalLineDetail);
            }
        }

        return lineItem;

    }
    

    
    
    public virtual override string getDTOClassName(){
        return 'QboInvoiceLineBase';
    }


    public override Schema.SobjectType getSobjectType(){
        return Invoice_Line_Item__c.getSobjectType();
    }
    
    protected Invoice_Line_Item__c initialize(){
        Invoice_Line_Item__c lineItem = new Invoice_Line_Item__c();
        lineItem.DetailType__c = this.DetailType;
        lineItem.Line_Number__c = this.LineNum;
        lineItem.Amount__c = Amount;
        return (Invoice_Line_Item__c)this.relateToParent(lineItem);
    }
   
}