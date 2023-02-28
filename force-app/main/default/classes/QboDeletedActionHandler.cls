public virtual class QboDeletedActionHandler extends QboAbstractActionHandler {
    
    public override void execute(Qbo_Event__c event){
        string qboId = event.Entity_Id__c;
        string entity = event.Entity__c;

        QboDataSyncMetadaProvider metadataProvider = QboDataSyncMetadaProvider.getInstance(entity);
        string sobjectType = metadataProvider.getSobjectType();
        string query = 'Select Id From ' +sobjectType + ' WHERE Qbo_Id__c =\''+qboId+'\'';
        Sobject record = Database.query(query)[0];

        Database.delete(record);
        
    }

}