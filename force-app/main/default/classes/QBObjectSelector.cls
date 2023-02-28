/**
 * Provides a way to do SOQLs for Objects Dynamically
 * NOTE: @see getMostRecent does not support Custom metadata types
 * */
public class QBObjectSelector {

    private final Schema.SObjectType sobjectType;
    private Map<string,Schema.SObjectField> fieldMap;
    
    public enum DbOp {CREATED , UPDATED}
    
    
    public QbobjectSelector(string objApiName){
        Map<String,Schema.SObjectType> globD = Schema.getGlobalDescribe();
        for(string obj : globD.keySet()){
            if(obj.equalsIgnoreCase(objApiName)){
                sobjectType = globD.get(obj);
                fieldMap = sobjectType.getDescribe().fields.getMap();
                system.debug(fieldMap);
                break;
            }
        }
    }
    
    public QbobjectSelector(schema.SObjectType objApiType){
        sobjectType = objApiType;
    }
    
    
    
  
    
    
    public string allfieldQuery(){
        string fieldQ = 'Select ' + String.join(new List<String>(fieldMap.keySet()), ', ') + ' FROM ' + sobjectType.getDescribe().getName();
 		return fieldQ;       
    }
    
    
    public List<Sobject> getMostRecent(DBOp operation ,integer size){
        
        string fieldToUse = operation == DBOp.CREATED ? 'CreatedDate' : 'LastModifiedDate';
        string clause = ' ORDER BY ' + fieldToUse + ' DESC ' + ' LIMIT ' + size ;
        
        return Database.query(allFieldquery() + clause);
        
        
    }
    
    
}