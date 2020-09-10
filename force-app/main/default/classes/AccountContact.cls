public class AccountContact {
    public static void actCont(){
        
       Map<Id, Contact> cnts = New Map<Id, Contact>();
       Set<Id> actIds = New Set<Id>();
       List<Contact> cont = [Select Id, Name, AccountId From Contact Limit 100];
        for(Contact con : cont){
            actIds.add(con.AccountId);
        }
        List<Contact> conntname = [Select Name From Contact Where AccountId In:actIds];
        for(Id aid : actIds){
            cnts.putall(conntname);
            //cnts.put(aid.valueOf(AccountId), aid.valueOf(Name));
        }
        
    }
}