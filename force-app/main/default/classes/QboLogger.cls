public virtual without sharing class QboLogger {
    
    private static QboLogger instance;
    

    public static QboLogger getinstance(){
        if(instance == null){
            instance = new QboLogger();
        }
        return instance;
    }
    
    
    private List<Log__c> logs;
    private boolean commitImmediately;
    private integer autoCommitSize;
    
    private QboLogger() {
        logs = new List<Log__c>();
        commitImmediately = false;
        autoCommitSize = 10;
    }
    

    public void toggleCommitImmediately(boolean commitImmediately) {
        this.commitImmediately = commitImmediately;
    }

    public void setAutoCommitSize(integer autoCommitSize) {
        this.autoCommitSize = autoCommitSize;
    }


    public QboLogger log(Exception e){
        Log__c l = new Log__c();
        string dumps = 'Exception At : ' +e.getStackTraceString() +'\n' +'Message : '+ e.getMessage();
        l.Dumps__c = dumps;
        logs.add(l);
        write();
        return this;
    }

    public QboLogger log(string raw){
        Log__c log = new Log__c();
        log.dumps__c = raw;
        logs.add(log);
        write();
        return this;
    }



    private void write(){
        if(commitImmediately == true || logs.size() == autoCommitSize){
            insert logs;
            logs = new List<Log__c>();
        }
    }

    public void close(){
        this.toggleCommitImmediately(true);
        write();
    }

    
}