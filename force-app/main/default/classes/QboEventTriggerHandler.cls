public class QboEventTriggerHandler {

    
    public static void Handle(List<Qbo_Event__c> records){
        QboLogger logger = QboLogger.getinstance().log('events received : ' + Json.serialize(records));
        try{
            System.enqueueJob(new QBOEventProcessingQueue(records));
            
        }catch(Exception e){
            logger.log(e);    
        }
        logger.close();
        
        
    }
    
    
}