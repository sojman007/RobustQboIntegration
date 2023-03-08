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
    
    public Date InvStartDate {get;set;}
    
    public double QtyOnHand {get;set;}
    public double AbatementRate {get;set;}
    public double ReorderPoint {get;set;}
    public double ReverseChargeRate {get;set;}
    public double PurchaseCost {get;set;}
    public double UnitPrice {get;set;}
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
        item.Abatement_Rate__C = this.AbatementRate;
        item.Active__c = this.Active;
        item.Asset_Account_Reference__c = this.AssetAccountRef.value;
        item.Description__c = this.Description;
        item.Expense_Account_Ref__c = this.ExpenseAccountRef.value;
        item.Fully_Qualified_Name__c = this.FullyQualifiedName;
        item.Income_Account_Reference__c = this.IncomeAccountRef.value;
        item.Level__c = this.Level;
        item.Parent_Ref__c = this.ParentRef.value;
        item.Preferred_Vendor_Reference__c = this.PrefVendorRef.value;
        item.Purchase_Cost__c = this.PurchaseCost;
        item.Purchase_Description__c = this.PurchaseDesc;
        item.Purchase_Tax_Code_Reference__c = this.PurchaseTaxCodeRef.value;
        item.Purchase_Tax_Included__c = this.PurchaseTaxIncluded;
        item.Qbo_Id__c = this.Id;
        item.Quantity_On_Hand__c = this.QtyOnHand;
        item.Reorder_Point__c = this.ReorderPoint;
        item.Reverse_Charge_Rate__c = this.ReverseChargeRate;
        item.Sales_Tax_Code_Reference__c = this.SalesTaxCodeRef.value;
        item.Sales_Tax_Included__c = this.SalesTaxIncluded;
        item.Service_Type__c = this.ServiceType;
        item.Sku__c = this.Sku;
        item.Source__c = this.Source;
        item.Sub_Item__c = this.SubItem;
        item.Sync_Token__c = this.SyncToken;
        item.Tax_Classification_Reference__c = this.TaxClassificationRef.value;
        item.Taxable__c = this.Taxable;
        item.Track_Qty_On_Hand__c = this.TrackQtyOnHand;
        item.Unit_Price__c = this.UnitPrice;
        item.UQC_Display_Text__c = this.UQCDisplayText;
        item.UQC_Id__c = this.UQCId;
        return item;
    }

}