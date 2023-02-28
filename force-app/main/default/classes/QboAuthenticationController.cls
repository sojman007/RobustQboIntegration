public class QboAuthenticationController {

    public QboAuthenticationController(){
    }
    
    /**
     * @description : Requests for an Authorization Code, which the services can use to request a Jwt for authentication
     * */
    public PageReference Authorize(){
        QBoSettingsProvider provider = QboSettingsProvider.getInstance();
        string endPoint = provider.getFullOAuthUrl('com.intuit.quickbooks.accounting',
                                               provider.getCallBackUrl());
        
        return new PageReference(endPoint);
        
    }
}