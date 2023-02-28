public virtual class QboEventProcessingQueue extends IAsyncCollectionDs_Link implements Queueable , Database.allowsCallouts {
	
    public QBoEventProcessingQueue(List<Qbo_Event__c> events){
        for(Qbo_Event__C event : events){
            super.addNode(new QboEventProcessingNode(event));
        }
    }
    
    public void execute(QueueableContext ctx){
        try{
            IAsyncCollectionDSNode node = getNext();
        	node.execute();
            if(hasNext()){
                index += 1;
                System.enqueueJob(this);
            }
        }catch(Exception e){
            QboLogger logger = QboLogger.getinstance();
            logger.log(e);
            logger.close();
        }
        
    }
    
    
    
    
    
    
    
}