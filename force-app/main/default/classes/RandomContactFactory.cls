//@isTest
public class RandomContactFactory {
	public static List<Contact> generateRandomContacts(Integer numConts, String ConLname)
    {
        List<Contact> concts = new List<Contact>();
        
        for(Integer i=0;i<numConts;i++) {
            Contact c = new Contact(FirstName='TestFname' + i, LastName = 'TestLname' + i);
            concts.add(c);
        }
        insert concts;
        
        return concts;
    }
}