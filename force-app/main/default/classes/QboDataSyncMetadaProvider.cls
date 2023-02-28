/**
 * @description : provides a uniform interface to retreive metadata for integration operations
 * */
public class QboDataSyncMetadaProvider {

    
    
    public enum Action {CREATED , UPDATED , DELETED}
   
    private map<string,Action> qboActions = new Map<string,Action>{'create'=>Action.CREATED, 'update'=>Action.UPDATED , 'delete'=>Action.DELETED};
        
   
    
    private static QboDataSyncMetadaProvider instance;
    
    private string ofType;
    
    private Qbo_DataSync_Options__mdt options;
    
    
    
    public boolean equals(string dType){
        return ofType.equalsIgnoreCase(dType);
        
    }
    
    
    public Action getActionFromName(string actionAlias){
        return qboActions.get(actionAlias);
    }
    
    public static QBoDataSyncMetadaProvider getInstance(string dtype){
        if(instance == null || !instance.equals(dtype)){
            instance = new QbodataSyncMetadaProvider(dType);
        }
        return instance;
    }
    
    
    private QBoDataSyncMetadaprovider(string stype){
        this.ofType = sType;
        List<Sobject> sobjects = new List<Sobject>();
        string allFieldQuery = new QbobjectSelector('Qbo_DataSync_Options__mdt').allFieldQuery();
        allFieldquery += ' Where Qbo_Entity__c = \'' + stype + '\'';
        sobjects = Database.query(allFieldquery);
        if(sobjects != null && sobjects.size() > 0){
            options = (Qbo_DataSync_Options__mdt)sobjects[0];
        }
    }
    
    public List<Action> getAllowedActions(){
        List<Action> actions = new List<Action>();
        
        if(options.Subscribe_To_Create_event__c){
            actions.add(Action.CREATED);
        }
        if(options.Subscribe_To_Update_Event__c){
            actions.add(Action.UPDATED);
        }
        
        if(options.Subscribe_To_Delete_Event__c){
            actions.add(Action.DELETED);
        }
        
        return actions;
        
    }


    public string getSobjectType(){
        return options.Sobject_Type__c;
    }
    
    
    
    
    
   
    
    
    
    
    
}