global class TestAccountsDelete implements Database.Batchable<sobject>
{

public String query;

global Database.QueryLocator start(Database.BatchableContext BC)
 
{
  return Database.getQueryLocator(query);


}

global void execute(Database.BatchableContext BC,List<sobject> scope)
{

List<Account> acctList=new List<Account>();

for(sobject s:scope)
{
 Account acct=(Account)s;
 acctList.add(acct);
 
}

delete acctList;

}

global void finish(Database.BatchableContext BC)
{

AsyncApexJob delJob=[select Id,Status,NumberOfErrors,TotalJobItems,JobItemsProcessed,createdBy.Email from 
AsyncApexJob where id=:BC.getJobId()];

String display='Batch Status'+delJob.Status+'Total Batches exceuted'+delJob.JobItemsProcessed+'Batch job created by email id'+delJob.createdBy.Email;
Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
OrgWideEmailAddress org=new OrgWideEmailAddress();
email.setOrgWideEmailAddressId(org.id);
String[] toAddresses=new String[]{'utpala.raghunath@gmail.com','raghunath.utpala@gmail.com'};
email.setToAddresses(toAddresses);
email.setHtmlBody(display);
Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});





}

}