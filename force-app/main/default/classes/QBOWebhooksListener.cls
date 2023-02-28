@RestResource(urlmapping='/qbsync/*')
global class QBOWebhooksListener {
    
    @HttpPost 
    global static void ReceiveEvent(){
        RestRequest req = RestContext.request;
        Map<string,string> params = req.params;
        
        string requestURI = req.requestURI;
        string requestBodyJson = req.requestBody.toString();
        QboEventParser.parse(requestBodyJson);
    }
    
    
    
    
    

}