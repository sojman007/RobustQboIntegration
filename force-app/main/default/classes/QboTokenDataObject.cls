public virtual class QboTokenDataObject extends QboDataObject implements IConvertible {

    public string refreshToken {get;set;}
    public Datetime lastAuthDate {get;set;}
    public integer refreshTokenExpiry {get;set;}


    public Sobject convert(){
        Qb_Token__c token = new Qb_Token__c();
        token.RefreshToken__c = this.refreshToken;
        token.Last_Auth_Date__c = this.lastAuthDate;
        return token;

    }
    
}