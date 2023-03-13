public abstract class QboAbstractDataChildObject extends QboDataObject{
    
    protected string parentId;
    protected string relationshipField;
    
    
    public abstract Schema.SobjectType getSobjectType();

    public virtual void setParentRef(SObject parent){
        this.parentId = parent.id;
        this.relationshipField = setRelationshipField(parent.getSobjectType());
    }

    protected virtual Sobject relateToParent(Sobject record){
        if(this.parentId != null && this.relationshipField != null)
            record.put(this.relationshipField, this.parentId);
        return record;
    }

    private string setRelationshipField(Schema.SObjectType parentType){
        List<Schema.SObjectField> fieldList = this.getSobjectType().getDescribe().fields.getMap().values();

        for (Schema.SObjectField field : fieldList) 
        {

            Schema.DescribeFieldResult fieldDesc = field.getDescribe();
            if(fieldDesc.getReferenceTo().contains(parentType)){
                return fieldDesc.getName();
            }
        }
        return '';
    }
}