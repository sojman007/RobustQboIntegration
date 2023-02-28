public virtual class QBOEventProcessingNode extends IAsyncCollectionDsNode{

    public QBoEventProcessingNode(Qbo_Event__c data){
        this.data = data;
        this.dataType = Qbo_Event__c.class;
        
    }
    
    
    // use metadata provider to determine what to do
    // When Immediate : Make a Callout To retreive the data and kickstart callout Processing; 
    // system is already in an asynchronour context when this runs , so that leaves us with just one Queueable Job to run !!!!
    
    public override void execute(){
        QBo_Event__c event = (QBo_Event__c)data;
        QboDataSyncMetadaProvider meta = QboDataSyncMetadaProvider.getInstance(event.Entity__c);
        QboDataSyncMetadaProvider.Action eventAction = meta.getActionFromName(event.Operation__c.toLowerCase());
        QboLogger l = QboLogger.getinstance();
                
        if(eventAction != null && meta.getAllowedActions().contains(eventAction)){
            try{
                QBoAbstractActionHandler handler = QboActionHandlerFactory.getAction(eventAction);
                handler.execute(event);    
            }catch(Exception e){
               throw e;
            }
        }else{
            l.log(' An Invalid Action Unsubscribed action was invoked');
        }
        
    }
    
    
    
}