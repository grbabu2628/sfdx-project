@isTest
public class LeadProcessorTest {
    
    @isTest    
    public static void testit() {
        List<lead> l_lst = new List<lead>();
        for (Integer i = 0; i<200; i++) {
            Lead l = new lead();
            l.LastName = 'Trailname'+i;
            l.company = 'Trailcompany';
            l.Status =  'Trailsomestatus';
            l_lst.add(l);
        }
        insert l_lst;
        
        test.startTest();
        
        Leadprocessor lp = new Leadprocessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
            
    }

}