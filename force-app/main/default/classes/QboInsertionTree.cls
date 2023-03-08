public virtual class QboInsertionTree extends IAsyncCollectionDS_Link implements System.Queueable {
    
    
    
    public QboInsertionTree(QboInsertionNode Root){
        this.addNode(root);
    }
    
    
    
    // can we abort the event processing queue job here ??
    public class QboInsertionNode extends IAsyncCollectionDsNode{
        
        public QboInsertionNode(QboDataObject data){
            this.data = data;
        }
        
        public void SetParent(Sobject rec){
            ((QboAbstractDataChildObject)data).setParentRef(rec);
        }
        
        
        public QboDataObject getDataObject(){
            return (QboDataObject)data;
        }
        
        // we really dont need this method here but it is inherited so wahaluurrr
        public override void execute(){}
        
        
        
        
    }
    
    public void execute(){
        Sobject recordToinsert;
        try{
            QboInsertionNode toExecute = (QboInsertionNode)getNext();
            QboDataObject objectOfInterest = toExecute.getDataObject();
            if(objectOfInterest.isConvertible()){
                recordToInsert = ((IConvertible)objectOfInterest).convert();
                upsert recordToinsert;
            }
            if(objectOfInterest.isChildrenable()){
                List<QboDataObject> children = ((IChildrenable)objectOfInterest).getChildren();
                if(children != null && children.size()>0){
                    for(QboDataObject child : children){
                        QboInsertionNode node = new QboInsertionNode(child);
                        node.setParent(recordToInsert);
                		this.addNode(node);        
                    }
                }
                
            }
            QboLogger.getinstance().log('Upserted Record with Id ' + recordToinsert.Id).close();
            
            if(this.hasNext()){
                index += 1;
                system.enqueueJob(this);
            }
        
        }catch(Exception e){
        
        }
    }
    
    public void execute(System.QueueableContext context){
       execute();
    }

}