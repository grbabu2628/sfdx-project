@isTest
public class TestRestrictContactByName {
    @isTest static void testRestrictContactByName() 
    {
        Contact cont = new Contact(LastName='Test Contact');
        insert cont;
    }
    @isTest static void testRestrictContactByName1() 
    {
        Contact cont = new Contact(LastName='INVALIDNAME');
        insert cont;
    }
}