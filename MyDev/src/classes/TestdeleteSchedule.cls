global class TestdeleteSchedule implements Schedulable
{

global void execute(SchedulableContext SC)

{
  TestAccountsDelete delJob=new TestAccountsDelete();
  delJob.query='select id from Account where Name like \'%Test%\'';
  Database.executeBatch(delJob);


}


}