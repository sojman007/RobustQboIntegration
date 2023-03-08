/**
 * Handles the oAuth2 Flow by saving tokens in sf and automatically refreshing tokens
 * */
public class QuickBooksOAuth2Handler {
	
    public static PageReference ref;

    

    
    // maybe we can just modify this to authenticate once and for all (for first requests)
    // that way the qboauthhandler token always HAS a refresh token.
    public static void renewSession(map<string,string> params){
        QboLogger logger = QboLogger.getinstance();

        logger.log('renewing session');
        QB_Token__c mostRecent = new Qb_Token__c(Auth_Token__c = params.get('code') , Realm_Id__c = params.get('realmId'));
        Cache.OrgPartition localStorage = Cache.Org.getPartition('local.QboCache');
        // temporarily put these in cache !!! 
        localStorage.put('accesscode', params.get('code'));
        localStorage.put('realmId', params.get('realmId'));
        
        QboAuthHandler authHandler = QboAuthHandler.getInstance();
        if(authHandler.authenticate() == true){
            string refreshToken = (string)authHandler.getLastAuthResponseValueForKey('refresh_token');
            integer refreshTokenExpiry = (integer)authHandler.getLastAuthResponseValueForKey('x_refresh_token_expires_in');
            mostRecent.Last_Auth_Date__c = Datetime.now();
            mostRecent.Refresh_Token_Expiry__c = refreshTokenExpiry; 
            mostRecent.Refresh_Token__c = refreshToken;
            mostRecent.Access_Code_Life_Span_days__C = 101;
        }

        logger.log(Json.serialize(mostRecent));
        logger.close();
        insert mostRecent;
    }
    
    
    
    
    
    
    
}