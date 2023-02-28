trigger QboEventTrigger on QBO_Event__c (after insert) {

    QboEventTriggerHandler.handle(Trigger.New);
    
    
}