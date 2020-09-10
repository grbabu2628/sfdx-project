trigger ClosedOpportunityTrigger on Opportunity (after insert) {
    List<Task> tskList = new List<Task>();
	for(Opportunity o : Trigger.New) {
        if(o.StageName == 'Closed Won')
        {
          tskList.add(New Task (Subject = 'Follow Up Test Task', WhatId = o.Id));
        }
    }
    if (tskList.size() > 0) {
        insert tskList;
    }
}