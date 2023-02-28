/**
 * Represents Objects that have complex datatypes as children (especially if those children have to be converted to records)
 * 
 * */
public interface IChildrenable {

    List<QboDataObject> getChildren();
    
    
    
}