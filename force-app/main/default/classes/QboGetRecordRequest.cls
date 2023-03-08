public class QboGetRecordRequest extends QboCalloutService.BaseRequest {
    
    
    public QboGetRecordRequest(){
        httpMethod = 'GET';
    }
    
    
    public override string getRequestPath(){
        QboSettingsProvider provider = QBoSettingsProvider.getInstance();
        string unformattedPath = provider.getFullApiUrlTemplate();
        string joinedEntityAndId = String.join(orderedPathExtras, '/');
        return string.format(unformattedPath, new List<string>{joinedEntityAndId});
    }
    
    // This is gonna update the jwt  token for first time requests (when jwt does not exist) !!!! 
    // A possible complication here is that we are still within an active asynchronous queueable context so we can't call another queueable 
    // calling another queueable here causes the processing queueable to NOT run. 
    // i.e QBO Event processing Node. Which executes on until there are no event nodes to process !!!
        
    public override Map<string,string> getHeaders(){
        Map<String,string> existingHeaders = defaultHeaders();
        existingHeaders.put('Authorization', 'Bearer ' + authenticationService.getJwtToken());
        
        return existingHeaders;
    } 
    
    public override  string getBody(){
        return null;
    }
    
    public override QboCalloutService.BaseResponse response(HttpResponse res ){
       return new QboGetRecordResponse(res);
    }
    
    
    
    
    
    
    public class QboGetRecordResponse extends QBoCalloutService.BaseResponse{
        
        public QboGetRecordResponse(HttpResponse res){
            setHttpResponse(res);
        }
        
        // functions for both create and update events
        public override void process(string entityName){
            string jsonResponse = httpR.getBody();
            QboLogger logger = QboLogger.getinstance();
            logger.log(httpR.getBody() + '\n status : ' + httpR.getStatusCode());
            Map<string,object> topLevel = (Map<string,Object>)Json.deserializeUntyped(jsonResponse);
            string newJson = Json.serialize(topLevel.get(entityName));
            System.Type parseTarget = QboParseTargetfactory.getParseTarget(entityName);
            
            logger.log('found parse target ' + parseTarget + '\n json data : ' + newJson);

            // NOTE : sets the Salesforce Id for when the operation is an update operation.
            // when its a create, the Id is not set , this logic is encapsulated in the QboDataObject
            QboDataObject parsedData = (QboDataObject)Json.deserialize(newJson, parseTarget);
            if(dataSaveMode == QboEnums.DATA_SAVE_MODE.MODIFY){
                string recordId = getSfRecordId(entityName, parsedData.Id);
                logger.log('found sf record id : ' + recordId);
                parsedData.sfRecordId = recordid;
            }
            logger.log('parsed data = > \n' +json.serialize(parsedData));
            logger.close();
            QboInsertionTree.QboInsertionNode node = new QboInsertionTree.QboInsertionNode(parsedData);
            QboInsertionTree tree = new QboInsertionTree(node);
            System.enqueueJob(tree);
        }
        
        public override Sobject getData(){
            return this.data;
            
        }

        
        
        
        
        
        
    }
    

}