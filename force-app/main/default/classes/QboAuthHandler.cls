public class QboAuthHandler {
    
    private static QboAuthHandler instance;
    
    Cache.OrgPartition localStorage = Cache.Org.getPartition('local.QboCache');
    private boolean UseRefreshToken = false;
    
    private map<string,Object> authResponseData;
    
    public static QboAuthHandler getInstance(){
        
        if(instance == null)instance = new QboAuthHandler();
        return instance;
    }
    
    private Qb_Token__c token;

    private string accessCode = '';
    private string realmId ='';
    
    private QboAuthHandler(){
        QbObjectSelector selector = new QbObjectSelector('QB_Token__c');
        List<Sobject> data = selector.getMostRecent(QbObjectSelector.DbOp.CREATED,1);
        QboLogger logger = QboLogger.getInstance();
        logger.log('Initializing auth handler with token record : \n ' + JSON.serialize(data));
        if(data != null && data.size() > 0){
            token = (QB_Token__c)data[0];
            accessCode = token.Auth_Token__c;
            realmId = token.Realm_Id__c;
            UseRefreshToken = token?.RefreshToken__c != null && !refreshTokenIsExpired();
        }else{
            // check Local storage for access Code ...
            setAccessParamsFromCache();
        }
        if(UseRefreshToken == false){
            setAccessParamsFromCache();
        }

    }

    private void setAccessParamsFromCache(){
        accessCode = (string)localStorage.get('accesscode');
        realmId = (string)localStorage.get('realmId');
    }
    
    // exposes api for other callers to access datapoints from the authentication HTTP callout
    public object getLastAuthResponseValueForKey(string key){
        return authResponseData.get(key);
    }

    // return jwt token 
    public string getJWTToken(){
        if(tokenIsExpired()){
            UseRefreshToken = true;
            boolean authed = authenticate();
        }
        return (string)localStorage.get('jwt'); 
        
        
    }
    // requests a new Jwt token using the auth Code if auth token exists , otherwise 
    // notify user to refresh access 
    // store token in local storage
    public boolean authenticate(){
        QboLogger logger = QboLogger.getInstance();
        logger.toggleCommitImmediately(false);
        logger.log('Are we using the refresh Token to request a JWT ? ' + UseRefreshToken);
        string redirectUrl = QboSettingsProvider.getInstance().getCallBackUrl();
        
        QBOAuthenticationRequest req = new QboAuthenticationRequest(accessCode, 
                                                                    realmId,redirectUrl , 
                                                                   	UseRefreshToken ? QboAuthenticationRequest.Mode.REFRESH : QboAuthenticationRequest.Mode.FRESH);
        
        
        QboAuthenticationRequest.QboAuthenticationResponse res = req.execute();
        Map<string,Object> responseData = res.get();
        authResponseData = responseData;
       	boolean success = false;
        // if refresh token flow , add the new refresh token update job to the insertion tree.
        if(res.success == true && responseData != null){
            string jwt = (String)responseData.get('access_token');
            string refreshtoken = (String)responseData.get('refresh_token');
            integer refreshExpiry =(Integer)responseData.get('x_refresh_token_expires_in');
            localStorage.put('jwt',jwt);
            localStorage.put('expiry', DateTime.now().addMinutes(50));
            localStorage.put('lifetime', responseData.get('expires_in'));
            localStorage.put('refreshtoken', refreshtoken);    
        	success = true;
            
            if(UseRefreshToken ==true){
                QboTokenDataObject tokenData = new QboTokenDataObject();
                tokenData.refreshToken = refreshtoken;
                tokenData.lastAuthDate = Datetime.now();
                tokenData.refreshTokenExpiry = refreshExpiry;
                QboInsertionTree.QboInsertionNode root = new QboInsertionTree.QboInsertionNode(tokenData);
                QboInsertionTree insertionTree = QboInsertionTree.getInstance(root);
            }
        }
        logger.log('jwt token put in cache is now  : ' +localStorage.get('jwt'));
        return success;
    }
    
    // compute expiry of jwt token 
    private boolean tokenIsExpired(){
        DateTime tokenExpiry = (DateTime)localStorage.get('expiry');
        System.debug('token expiry date time : ' +tokenExpiry);
        integer lifeTime = (integer)localStorage.get('lifetime');
        System.debug( 'token lifetime ' + lifetime);
        if(tokenExpiry != null && lifeTime != null){
            return getMinuteDifference(DateTime.now() , tokenExpiry) >= lifeTime;
        }
        return true;
    }
    
    public integer getMinuteDifference(DateTime first , Datetime Second){
        
        Long firstL = first.getTime();
        Long secondL = second.getTime();
        
        return (Integer)(firstL - secondL)/(60000);
    }
    
    // compute expiry of refresh token
    private boolean refreshTokenIsExpired(){
        Datetime refreshTokenBirth = this.token.Last_Auth_Date__c;
        integer refreshTokenLifeSpan = (Integer)this.token.Refresh_Token_Expiry__c;
        return(getMinuteDifference(Datetime.now(),refreshTokenBirth) >= refreshTokenLifeSpan); 
    }
    
    
}