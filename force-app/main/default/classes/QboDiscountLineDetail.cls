public virtual class QboDiscountLineDetail {
    public QboDataObject.ReferenceType ClassRef {get;set;}
    public QboDataObject.ReferenceType TaxCodeRef {get;set;}
    public QboDataObject.ReferenceType DiscountAccountRef {get;set;}
    
    public boolean PercentBased {get;set;}
    public decimal DiscountPercent {get;set;}
    
    
}