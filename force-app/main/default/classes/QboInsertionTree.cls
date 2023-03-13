public virtual class QboInsertionTree extends IAsyncCollectionDS_Link implements System.Queueable {
    
    private  static QboInsertionTree instance;
    
    public  static QboInsertionTree getInstance(QboInsertionNode Root){
        if(instance == null){
            instance = new QboInsertionTree(Root);
        }else{
            instance.add(root);
        }
        return instance;
    }

    public static QboInsertionTree getInstance(){
        if(instance == null){
            instance = new QboInsertionTree();
        }
        return instance;
    }


    public integer getSize(){
        return this.nodes.size();
    }
    
    private QboInsertionTree(){

    }

    private QboInsertionTree(QboInsertionNode Root){
        this.addNode(root);
    }
    
    public void add(QboInsertionNode node){
        this.addNode(node);
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
            System.debug('Object of Interest is of type : ' + objectOfInterest.getDTOClassName());
            if(objectOfInterest.isConvertible()){
                recordToInsert = ((IConvertible)objectOfInterest).convert();
                upsert recordToinsert;
                Id recordId = (Id)recordToInsert.get('Id');
                System.debug('upserted record successfully with Id : ' + recordId +' For SobjectType : ' + recordId.getSobjectType());
            }
            if(objectOfInterest.isChildrenable()){
                List<QboDataObject> children = ((IChildrenable)objectOfInterest).getChildren();
                System.debug('upserted record has children : ' + children.size());
                if(children != null && children.size()>0){
                    for(QboDataObject child : children){
                        QboInsertionNode node = new QboInsertionNode(child);
                        node.setParent(recordToInsert);
                		this.addNode(node);        
                    }
                }
                
            }
            
            if(this.hasNext()){
                index += 1;
                system.enqueueJob(this);
            }
        
        }catch(Exception e){
            System.debug('an exception has occured ' + e.getMessage() + '\n' + e.getStackTraceString());
            QboLogger logger = QboLogger.getInstance();
            logger.log(e);
            logger.close();
        }
    }
    
    public void execute(System.QueueableContext context){
       execute();
    }

}