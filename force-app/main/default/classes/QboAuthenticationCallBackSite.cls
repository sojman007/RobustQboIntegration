@RestResource(urlmapping ='/qbcallback')
global class QboAuthenticationCallBackSite {
   
    @HttpGet
    global static void handleCallbackGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        Map<string,string> params = req.params;
        QuickBooksOAuth2Handler.renewSession(params);
    }
    
    
    
    
}