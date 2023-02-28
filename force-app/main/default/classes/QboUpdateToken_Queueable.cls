// we might never need to use this anymore !!!!
public with sharing class QboUpdateToken_Queueable implements Queueable , Schedulable{
    
    string tokenId;
    integer expiry;
    string refreshT;

    public QboUpdateToken_Queueable(string tokenId, integer jwtexpiry , string refreshtoken) {
        this.tokenId = tokenId;
        this.expiry = jwtexpiry;
        this.refreshT = refreshToken;
    }


    public void execute(System.SchedulableContext context){
        executeCommon(context.getTriggerId(),'sch');
    }
    public void execute(System.QueueableContext cont){
        executeCommon(cont.getJobId(),'que');
    }


    private void executeCommon(string jobId, string ctx){
        try{
            Qb_Token__c token = new Qb_Token__c();
            token.put('Id', tokenId);
            token.Refresh_Token__c = this.refreshT;
            token.Jwt_Token_LifeSpan_Minutes__c = this.expiry;
            upsert token;
            if(ctx.equalsIgnoreCase('sch')){
                System.abortJob(jobId);
            }
        }catch(Exception e){
            QboLogger logger = QboLogger.getinstance();
            logger.log(e);
            logger.close();
        }
    }

    
}