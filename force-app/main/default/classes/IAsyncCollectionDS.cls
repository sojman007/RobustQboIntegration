public interface IAsyncCollectionDS {

    boolean hasNext();
    IAsyncCollectionDSNode getNext();
    void execute();
    
    
}