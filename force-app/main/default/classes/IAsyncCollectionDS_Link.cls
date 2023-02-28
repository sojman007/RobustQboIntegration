public abstract class IAsyncCollectionDS_Link implements IAsyncCollectionDS {
    
    protected integer index = -1;
    protected List<IAsyncCollectionDSNode> nodes;
    
    
    public virtual boolean hasNext(){
        return (index + 1) < nodes.size() -1;
    }
    
    public virtual IAsyncCollectionDSNode getNext(){
        
        return nodes[index + 1];
    }
    
    
    
    protected virtual void addNode(IAsyncCollectionDSNode node){
        if(nodes == null) nodes = new List<iAsyncCollectionDSNode>();
    	nodes.add(node);
    }

}