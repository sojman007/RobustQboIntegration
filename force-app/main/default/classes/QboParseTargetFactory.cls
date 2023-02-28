public class QboParseTargetFactory {
    
    // Update this register for every new QBO data object that we wanna parse into salesforce. 
    // Eventually we will move this into a custom settings/custom metadata
    private static map<string,string> targetMap = new Map<String,string>{'item'=>'QboItem' , 'invoice'=>'QboInvoice' , 'customer'=>'QboCustomer','salesreceipt' => 'QboSalesReceipt'};
    
    public static System.Type getParseTarget(string entityName){
        return Type.forName(targetmap.get(entityName.toLowerCase()));
    }

}