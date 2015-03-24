global class ScheduleDelTestAccts implements Schedulable

{
   global void execute(SchedulableContext SC)
   {
      DeleteTestAccts delJob=new DeleteTestAccts();
      delJob.query='select id from Account where Name like\'%Test%\'';
      database.executeBatch(delJob);
      
   }



}