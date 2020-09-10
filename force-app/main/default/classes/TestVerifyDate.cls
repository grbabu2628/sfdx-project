@isTest
public class TestVerifyDate {
    
    @isTest static void testCheckDates() 
    {
        Date date1 = System.today();
        Date date2 = System.today();
        VerifyDate.CheckDates(date1,date2);  
        
        VerifyDate.SetEndOfMonthDate(date1);
        //System.assertEquals(date1, date2);
      //  Date date3 = null;
      //  Date date4 = null;
     //   VerifyDate.CheckDates(date3,date3);  
        
    }
    @isTest static void testCheckDates1() 
    {
       
        Date date3 = system.today();
        Date date4 = system.today();
        Date date30Days = date3.addDays(30);
         VerifyDate.CheckDates(date30Days,date4);  
       // VerifyDate.DateWithin30Days(date30Days,date4);  
         VerifyDate.SetEndOfMonthDate(date3);
        
    }
    
    
}