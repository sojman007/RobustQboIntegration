public abstract class QboAbstractActionHandler {
	protected QBoSettingsProvider settingsProvider = QBoSettingsProvider.getInstance();
    protected QboCalloutService calloutService; 
    protected QboGetRecordRequest getRecordRequest = new QboGetRecordRequest();
    
    
    public abstract void execute(QBo_Event__c event);
    
    protected virtual QboGetRecordRequest.QboGetRecordResponse executeGetRecordFromEvent(Qbo_Event__c event){
        string qboId = event.Entity_Id__c;
        string entity = event.Entity__c;
        getRecordRequest.addToPath(entity.toLowerCase()).addToPath(qboId);
        return (QboGetRecordRequest.QboGetRecordResponse)getRecordRequest.execute();
    }
    
    
}