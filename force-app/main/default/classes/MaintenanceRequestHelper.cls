public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> updatedCases, Map<Id,Case> oldCaseMap){
        
        Set<Id> validCaseIds = new Set<Id>(); 
        for (Case c: updatedCases) {
            
            if (oldCaseMap.get(c.Id).Status != 'Closed' && c.Status == 'Closed') {
                
                if (c.Type == 'Repair' || c.Type == 'Routine Maintenance') {
                    
                    validCaseIds.add(c.Id);
                }
            }
        } 
        
        
        if (!validCaseIds.isEmpty()) {
            
            List<Case> newCases = new List<Case>();
            
            Map<Id,Case> closedCaseMap = new Map<Id,Case>([SELECT Id, Vehicle__c, Equipment__c, Equipment__r.Maintenance_Cycle__c, 
                                                           (SELECT Id, Equipment__c, Quantity__c FROM Work_Parts__r) 
                                                           FROM Case 
                                                           WHERE Id IN :validCaseIds]);
            
            Map<Id, Decimal> maintCycleMap = new Map<Id, Decimal>();
            
            
            AggregateResult[] results = [SELECT Maintenance_Request__c, MIN(Equipment__r.Maintenance_Cycle__c)cycle
                                         FROM Work_Part__c 
                                         WHERE Maintenance_Request__c IN :validCaseIds 
                                         GROUP BY Maintenance_Request__c];
            
            
            for (AggregateResult ar : results) {
                maintCycleMap.put((Id) ar.get('Maintenance_Request__c'), (Decimal) ar.get('cycle') );
            }
            
            for (Case cc: closedCaseMap.values()){
                Case nc = new Case (ParentId = cc.Id,
                                    Status = 'New',
                                    Subject = 'Routine Maintenance',
                                    Type = 'Routine Maintenance',
                                    Vehicle__c = cc.Vehicle__c,
                                    Equipment__c = cc.Equipment__c,
                                    Origin = 'Web', 
                                    Date_Reported__c = Date.today());
                
                if (maintCycleMap.containsKey(cc.Id) ) {
                    nc.Date_Due__c = Date.today().addDays((Integer) maintCycleMap.get(cc.Id));
                } else {
                    nc.Date_Due__c = Date.today().addDays((Integer) cc.Equipment__r.Maintenance_Cycle__c);
                } 
                
                newCases.add(nc);
            }
            
            
            insert newCases;
            
            
            List<Work_Part__c> clonedWorkParts = new List<Work_Part__c>();
            for (Case nc: newCases) {
                for (Work_Part__c wp: closedCaseMap.get(nc.ParentId).Work_Parts__r) {
                    Work_Part__c wpClone = wp.clone();
                    wpClone.Maintenance_Request__c = nc.Id;
                    clonedWorkParts.add(wpClone);
                }
            }
            
            
            insert clonedWorkParts;
        }
    }    
    
}