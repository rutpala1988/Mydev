global class DeleteTestAccts implements Database.Batchable<sobject>
{

  public String query;
  
  global Database.QueryLocator start(Database.BatchableContext BC)
  {
  
  return Database.getQueryLocator(query);
  }
  
  global void execute(Database.BatchableContext BC,List<sobject> scope)
  {
    List<Account> acctlist=new List<Account>();

    for(sobject s:scope)
    {
    Account acct=(Account)s;
    acctlist.add(acct);
    }
    
    delete acctlist;
    
  }
  
  global void finish(Database.BatchableContext BC)
  {
    AsyncApexJob delJob=[select Id,Status,NumberOfErrors,TotalJobItems,JobItemsProcessed,CreatedBy.Email from 
    AsyncApexJob where id=:BC.getJobId()];
    
    Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
    String[] toAddresses=new String[]{'utpala.raghunath@gmail.com','raghunath.utpala@gmail.com'};
    //Map<Id,OrgWideEmailAddress> mapOrgWideEmailAddress=new Map<Id,OrgWideEmailAddress>();
    
    OrgWideEmailAddress org=new OrgWideEmailAddress(displayName='Team Salesforce',Address='teamsalesforce@sforce.com');
    //mapOrgWideEmailAddress.put(org.id,org);
    email.setOrgWideEmailAddressId(org.id);
    
    email.setToAddresses(toAddresses);
    email.setSubject('Batch Job Status'+delJob.Status);
    String display='The Batch Job Processed'+delJob.TotalJobItems+'with '+delJob.JobItemsProcessed+'Successful records'+delJob.NumberOfErrors+'Failed Records';
    display+='<br>'+'Thank you Salesforce team'+'<br>'+'<a href='+'www.salesforce.com>'+'Salesforce.com'+'</a>';
    email.setHtmlBody(display);
    Messaging.sendEmail(new Messaging.SingleEmailMessage []{email});
    
  
  }
  


}