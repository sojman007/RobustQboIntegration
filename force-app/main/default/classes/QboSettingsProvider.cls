public class QboSettingsProvider {

    public class NoSettingsFoundException extends Exception{}
    
    private static QboSettingsProvider instance;
    
    public static QboSettingsProvider getInstance(){
        if(instance == null) instance = new QboSettingsProvider();
        return instance;
    }
    
    private QuickBooks_Connection_Settings__c settingsRecord;
    private boolean canUse;
    
    private QboSettingsProvider(){
        settingsRecord = QuickBooks_Connection_Settings__c.getOrgDefaults();
        if(settingsRecord == null){
            throw new QboSettingsProvider.NoSettingsFoundException('Could not Find a default organizational record for QuickBooks_Connection_Settings__c. Please create one and try again');
        }
        canUse = settingsRecord != null;
    }
    
    
    public string getAuthenticationBaseUrl(){
        string res ='';
        if(canUse){
        	string authEndP = settingsRecord.Qbo_Auth_Endpoint__c.endsWithIgnoreCase('/') ? settingsRecord.Qbo_Auth_Endpoint__c : settingsRecord.Qbo_Auth_Endpoint__c+'/';
            res= authEndP;
        }
       return res;
    }
    
    public string getAccessTokenEndPoint(){
         string res ='';
        if(canUse){
        	res = settingsRecord.Qbo_FetchAccessToken_EndPoint__c;
        }
       return res;
    }
    
     public string getCallBackUrl(){
         string res ='';
        if(canUse){
        	res = settingsRecord.Callback_Url__c;
        }
       return res;
    }
    
    
    public string getFullOAuthUrl(string scopes, string redirecturi){
        string res ='';
        if(canUse){
         	string authEndP = settingsRecord.Qbo_Auth_Endpoint__c.endsWithIgnoreCase('/') ? settingsRecord.Qbo_Auth_Endpoint__c : settingsRecord.Qbo_Auth_Endpoint__c+'/';   
        	res = authEndP + '?client_id='+settingsRecord.Client_Id__c+'&response_type=code&scope='+scopes+'&state=123445633443&redirect_uri='+redirecturi;
        }
        return res;
    }
    
    // get authorization code
    public string getAuthFromClientIdAndSecret(){
        string res ='';
        if(canUse){
        	string clientId = settingsRecord.Client_Id__c;
        	string clientSecret = settingsRecord.Client_Secret__c;
            res = EncodingUtil.base64Encode(Blob.valueOf(clientId +':'+clientSecret));
        }
        
        return res;
    }
    
    public string getApiBaseUrl(){
        string res ='';
        if(canUse){
            res = settingsRecord.Is_QuickBooks_Sandbox__c ? settingsRecord.Sandbox_Base_Url__c : settingsRecord.Production_Base_Url__c;
        }
        return res;
    }

    public string getMinorVersionParam(){
        string res ='?minorversion=';
        if(canUse){
			res+= settingsRecord.Is_QuickBooks_Sandbox__c ? settingsRecord.Sandbox_Minor_Version__c : settingsRecord.Prod_Minor_Version__c;
        }
        
        return res;
    }
    public string getCompanyId(){
        string res = '';
        if(canUse){
            res+= settingsRecord.Is_QuickBooks_Sandbox__c ? settingsRecord.Sandbox_Company_Id__c : settingsRecord.Production_Company_Id__c;
        }
    	return res;
    }
    
    public string getFullApiUrlTemplate(){
        return getApiBaseUrl() +'/v3/company/'+ getCompanyId() +'/{0}'+ getMinorVersionParam();
        
    }    
    
    
    
    
    
}