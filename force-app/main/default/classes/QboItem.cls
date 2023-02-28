public virtual class QboItem extends QboDataObject implements IConvertible {
    
    public string ItemCategoryType {get;set;}
    public string Name {get;set;}
    public string Type {get;set;}
    public string Sku {get;set;}
    public string Source {get;set;}
    public string Description {get;set;}
    public string UQCDisplayText {get;set;}
    public string PurchaseDesc {get;set;}
    public string UQCId {get;set;}
    public string ServiceType {get;set;}
    public string FullyQualifiedName {get;set;}
    
    public QboDataObject.QDate InvStartDate {get;set;}
    
    public decimal QtyOnHand {get;set;}
    public decimal AbatementRate {get;set;}
    public decimal ReorderPoint {get;set;}
    public decimal ReverseChargeRate {get;set;}
    public decimal PurchaseCost {get;set;}
    public decimal UnitPrice {get;set;}
    public integer Level {get;set;}
    
    public boolean Active {get;set;}
    public boolean SalesTaxIncluded {get;set;}
    public boolean TrackQtyOnHand {get;set;}
    public boolean PurchaseTaxIncluded {get;set;}
    public boolean SubItem {get;set;}
    public boolean Taxable {get;set;}
    
    public QboDataObject.ReferenceType SalesTaxCodeRef {get;set;}
    public QboDataObject.ReferenceType AssetAccountRef {get;set;}
    public QBoDataObject.ReferenceType ClassRef {get;set;}
    public QboDataObject.ReferenceType PrefVendorRef {get;set;}
    public QboDataObject.ReferenceType PurchaseTaxCodeRef {get;set;}
    public QboDataObject.ReferenceType ParentRef {get;set;}
    public QboDataObject.ReferenceType ExpenseAccountRef {get;set;}
    public QboDataObject.ReferenceType IncomeAccountRef {get;set;}
    public QboDataObject.ReferenceType TaxClassificationRef {get;set;}
    
    
    
    public Sobject convert(){
        Qbo_Item__c item = (Qbo_Item__c)setDefaults(new Qbo_Item__c());


        return item;
    }

}