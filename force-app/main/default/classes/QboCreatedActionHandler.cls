public virtual class QboCreatedActionHandler extends QboAbstractActionHandler{
    
    
    
    public override void execute(Qbo_Event__c event){
        QboCalloutService.BaseResponse response = executeGetRecordFromEvent(event);
        response.setMode(QboEnums.DATA_SAVE_MODE.CREATE).process(event.Entity__c);
    }

}