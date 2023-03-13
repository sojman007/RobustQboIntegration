public class QBOCalloutService {

    // format  <OPERATION> <baseURL>/v3/company/<id>/<entity>?<minorversion>
    private static final HTTP qbHttp = new Http();
    
    
    public abstract class BaseRequest{
        
    	protected QboAuthHandler authenticationService = QboAuthHandler.getInstance();    
		public abstract string getRequestPath();
        public abstract Map<string,string> getHeaders();
        protected string httpMethod;
        public abstract string getBody();
        protected list<string> orderedPathExtras = new List<string>();
        
        
        public map<string,string> defaultHeaders(){
            
            return new Map<string,string>{'Content-type' =>'application/json' ,'accept' =>'application/json'};
        }
        
        public BaseRequest addToPath(string sub){
            orderedPathExtras.add(sub);
            return this;
        }
        
        
        
        public abstract BaseResponse response(HttpResponse res);
        
        public virtual BaseResponse execute(){
            HttpRequest req = new HttpRequest();
            req.setEndpoint(getRequestPath());
            Map<string,string> headers = getHeaders();
            for(string headerKey : headers.keySet()){
            	req.setHeader(headerKey, headers.get(headerKey));        
            }
            req.setMethod(httpMethod);
           	string body = getBody();
            if(String.isNotBlank(body)){
            	req.setBody(getBody());
            }
            
            HttpResponse res = qbHttp.send(req);
            QboLogger logger = QboLogger.getinstance();
            logger.log(getRequestPath());
            logger.log(json.serialize(headers));
        	return this.response(res);
        }
    } 
    
    public abstract class BaseResponse{
        protected HttpResponse httpR;
        protected Sobject data;
        protected QboEnums.DATA_SAVE_MODE dataSaveMode;
        
        protected void setHttpResponse(HttpResponse res){
            httpR = res;
        }
        
        public BaseResponse setMode(QboEnums.DATA_SAVE_MODE mode){
            dataSaveMode = mode;
            return this;
        }
        public abstract Sobject getData();
        public abstract void process(string entity);
        
        protected string getSfRecordId(string eventEntity , string qboId){
            QboDataSyncMetadaProvider metadataprovider = QboDataSyncMetadaProvider.getInstance(eventEntity);
            string objectType = metadataProvider.getSobjectType();
            string query = 'Select Id From ' +objectType + ' WHERE Qbo_Id__c =\''+qboId+'\'';
            string recordId =null;
            List<Sobject> records = Database.query(query);
            if(records != null && records.size() > 0){
                recordId = (string)records[0].get('Id');
            }
            return recordId;
        }
        
        
    }
    
    
    
    
}