public virtual class QboEventProcessingQueue extends IAsyncCollectionDs_Link implements Queueable, Database.allowsCallouts {
	
    public QBoEventProcessingQueue(List<Qbo_Event__c> events){
        for(Qbo_Event__c event : events){
            super.addNode(new QboEventProcessingNode(event));
        }
    }
    

    // make this class run in an asynchronous context but only once.
    public void execute(QueueableContext ctx){
        execute();
    }

    public void execute(){
        try{
            IAsyncCollectionDSNode node = getNext();
        	node.execute();
            if(hasNext()){
                index += 1;
                execute();
            }else{
                QboInsertionTree tree = QboInsertionTree.getInstance();
                System.debug('Tree size ' + tree.getSize());
                System.enqueueJob(tree);
            }
        }catch(Exception e){
            QboLogger logger = QboLogger.getinstance();
            logger.log(e);
            logger.close();
        }
        
    }
    
    
    
    
    
    
    
}