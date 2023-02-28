public virtual class QBOEventParser {
	
    private final string objectType = 'QBO_Event__c';
        
    public class QBOEvent{
        public List<QBOEventNotification> eventNotifications {get;set;}
        
        public void save(){
            List<QboDataChangeEventEntity> eventEntities = new List<QboDataChangeEventEntity>();
            List<Qbo_Event__c> eventRecords = new List<Qbo_Event__c>();
            if(eventNotifications != null && eventNotifications.size() > 0){
                for(QboEventNotification notf : eventNotifications){
                    eventEntities.addAll(notf.dataChangeEvent.entities);
                }
            }
            
            if(eventEntities.size() > 0){
                
                for(QboDataChangeEventEntity entity : eventEntities){
                    eventRecords.add(entity.get());
                }
                
                insert eventRecords;
            }
            
            
            
        }
    }
    
    public class QBOEventNotification{
        public string realmId {get;set;}
        public QboDataChangeEvent dataChangeEvent {get;set;}
        
    }
    
    public class QboDataChangeEventEntity{
        public string name {get;set;}
        public string id {get;set;}
        public string operation {get;set;}
        public DateTime lastUpdated {get;set;}
        
        public Qbo_Event__c get(){
            return new Qbo_Event__c(Entity__c = name , Entity_Id__c = Id , Operation__c = operation , Last_Updated__c = lastUpdated);
        }
    }
    
    public class QboDataChangeEvent{
        public list<QboDataChangeEventEntity> entities;
    }
    
    public static void parse(string eventJson){
        QBOEvent event = (QBOEvent)Json.deserialize(eventJson, QBOEvent.class);
        event.save();
    }
    
    
    
}