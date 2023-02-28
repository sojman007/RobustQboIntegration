public class QboActionHandlerFactory {

    public class QboNoActionFoundException extends Exception{}
    
    public static QbOAbstractActionHandler getAction(QboDataSyncMetadaProvider.Action action){
        QboAbstractActionHandler handler;
        switch on action{
            when CREATED{
                handler = new QboCreatedActionHandler();
            }
            when UPDATED{
                handler = new QboUpdatedActionHandler();
            }
            
            when DELETED{
                
                handler = new QboDeletedActionHandler();
            }
            when else{
                throw new QboNoActionFoundException('Invalid Action Supplied :  ' + action.name());
            }
        }
        
        return handler;
    }
    
    
}