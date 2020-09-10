@isTest
private class MaintenanceRequestTest {
	@testSetup static void setup() {
        
        Product2 testEquip40 = new Product2(name='test',maintenance_cycle__c=40,replacement_part__c=true);
        insert testEquip40;
        
       
        Product2 testEquip50 = new Product2(name='test',maintenance_cycle__c=50,replacement_part__c=true);
        insert testEquip50;
        
       
        Vehicle__c testVehicle = new Vehicle__c(name='test');
        

        List<Case> testCases = new List<Case>();
        for (Integer i=0;i<140;i++) {
        	Case c1 = new Case(Subject='Test '+ i,Status='New',Type='Repair',Equipment__c=testEquip50.Id,Vehicle__c=testVehicle.Id,Origin='Web');
            Case c2 = new Case(Subject='Test '+ 140 + i,Status='New',Type='Routine Maintenance',Equipment__c=testEquip50.Id,Vehicle__c=testVehicle.Id,Origin='Web');
            testCases.add(c1);
            testCases.add(c2);
        }
        for (Integer i=280;i<300;i++){
            Case c3 = new Case(Subject='Test '+i,Status='New',Type='Mechanical',Origin='Web');
            testCases.add(c3);
        }
        insert testCases;
        
        List<Work_Part__c> testWorkParts = new List<Work_Part__c>();
        for (Case c: testCases) {
            if (c.Type == 'Repair') {
                testWorkParts.add(new Work_Part__c(Maintenance_Request__c=c.Id,Equipment__c=testEquip40.Id));
                testWorkParts.add(new Work_Part__c(Maintenance_Request__c=c.Id,Equipment__c=testEquip50.Id));
            }
        }
		insert testWorkParts;
    }
    
    @isTest static void testCaseUpdate() {
       
        List<Case> cases = new List<Case>([SELECT Id, Status FROM Case WHERE Subject LIKE 'Test%']);
        
       
        for (Case c: cases) {
			c.Status = 'Closed';            
        }
        update cases;

       
        List<Case> updatedCases = [SELECT Id, Parent.Type FROM Case 
                                   WHERE Subject = 'Routine Maintenance'
                                     AND (Parent.Type = 'Repair' OR Parent.Type = 'Routine Maintenance')];
        System.assertEquals(updatedCases.size(), 280);


        Date due = Date.today().addDays(40);
        List<Case> repairCases = [SELECT Id, Parent.Type, Date_Due__c FROM Case
                                  WHERE Subject = 'Routine Maintenance'
                                    AND Parent.Type = 'Repair'
                                    AND Date_Due__c = :due];
        System.assertEquals(140, repairCases.size());
        
       
        List<Work_Part__c> workParts = [SELECT Id, Maintenance_Request__r.Subject, Maintenance_Request__r.Parent.Type 
                                        FROM Work_Part__c
                                        WHERE Maintenance_Request__r.Subject = 'Routine Maintenance'
                                                AND Maintenance_Request__r.Parent.Type = 'Repair'];
        System.assertEquals(280, workParts.size());

        due = Date.today().addDays(50);
        List<Case> rmCases = [SELECT Id, Parent.Type, Date_Due__c FROM Case
                                  WHERE Subject = 'Routine Maintenance'
                                    AND Parent.Type = 'Routine Maintenance'
                                    AND Date_Due__c = :due];
        System.assertEquals(140, rmCases.size());
    }
}