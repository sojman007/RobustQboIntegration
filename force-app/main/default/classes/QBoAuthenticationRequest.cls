public class QBoAuthenticationRequest {
    
    public enum Mode {FRESH , REFRESH}
    
    private final http h = new Http();
    private Mode exMode;
    private final string endPoint;
    private string accessCode;
    private string realmId;
    private string redirectUrl;   
    private QboSettingsProvider settings = QBoSettingsProvider.getInstance();
    
    public class QBoAuthenticationResponse{
        public boolean success;
        private Map<string,Object> data;
        
        
        public QBoAUthenticationResponse(HttpResponse res){
            System.debug(res.getBody());
           	success = res.getStatusCode() == 200;
            data = (Map<string,Object>)Json.deserializeUntyped(res.getBody());
            
        }
        
        public Map<String,Object> get(){
            return data;
        }
        
    }
    
    public QboAuthenticationRequest(string accessCode, string realmId, string redirectUrl , Mode mode){
        endPoint = settings.getAccessTokenEndPoint();
        exMode = mode;
        this.accessCode = accessCode;
        this.realmId = realmId;
        this.redirectUrl = redirectUrl;
    }
    
    
    public string getRequestBody(){
        string res = '';
        System.debug('executing in mode ' + exMode.name());
        switch on exMode{
            when FRESH{
                res = 'grant_type=authorization_code&code=' + accessCode + '&redirect_uri=' + redirectUrl;
            }
            when REFRESH{
                QbObjectSelector selector = new QbObjectSelector('QB_Token__c');
                Qb_Token__c token = (QB_Token__c)selector.getMostRecent( QbObjectSelector.DbOp.CREATED,1)[0];
                string refreshToken = token.Refresh_Token__c; 
                res = 'grant_type=refresh_token&refresh_token=' + refreshToken;
            }
            when else{
                res ='';
            }
        }
        
        return res;
        
        
    }
    
    
    
    public QboAuthenticationResponse execute(){
        string authorization = settings.getAuthFromClientIdAndSecret(); 
        HttpRequest httpReq = new HttpRequest();
        HttpResponse httpRes = new HttpResponse();
        
        string requestBody = getRequestBody();
        
        httpReq.setMethod('POST');
        httpReq.setEndPoint(endPoint);
        httpReq.setHeader('Authorization', 'Basic ' + authorization);
        httpReq.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        httpReq.setBody(requestBody);
        
        
        return new QBoAuthenticationResponse(h.send(httpReq));
    }
    
    
    
    
    
    
    
}