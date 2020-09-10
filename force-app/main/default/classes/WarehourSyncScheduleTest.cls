@isTest
public class WarehourSyncScheduleTest {
 static testmethod void testWarehouseSync() {
       String CRON_EXP = '0 0 1 * * ?';
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        Test.startTest();
        String jobId = System.schedule('WarehouseSyncSchedule',
                                       CRON_EXP, 
                                       new WarehouseSyncSchedule());   
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                          FROM CronTrigger
                          WHERE id = :jobId];

        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        Test.stopTest();
    }    

}