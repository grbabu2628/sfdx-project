public with sharing class WarehouseCalloutService {
    
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        //ToDo: complete this method to make the callout (using @future) to the
        //      REST endpoint and update equipment on hand.
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        List<Product2> prods2upsert = new List<Product2>();
        
        if (response.getStatusCode() == 200) {
            
            List<Object> itemList = (List<Object>) JSON.deserializeUntyped(response.getBody());  
            
            for(Object item: itemList) {
                Map<String,Object> itemMap = (Map<String,Object>) item;  
                Product2 warehouseProduct = new Product2(Name = (String) itemMap.get('name'),
                                                         Warehouse_SKU__c = (String) itemMap.get('_id'),
                                                         Replacement_Part__c = true,
                                                         Current_Inventory__c = (Integer) itemMap.get('quantity'),
                                                         Lifespan_Months__c = (Integer) itemMap.get('lifespan'),
                                                         Cost__c = (Decimal) itemMap.get('cost'),
                                                         Maintenance_Cycle__c = (Integer) itemMap.get('maintenanceperiod'));
                
                prods2upsert.add(warehouseProduct);
            }
            
            upsert prods2upsert;
        }
    }
}