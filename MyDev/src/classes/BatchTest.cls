global class BatchTest implements Schedulable
{
  global   void  execute(SchedulableContext sc)
  {
 BatchDelete bt=new BatchDelete();
bt.query='select id from Account where Name like \'test*\'';
ID batchprocessid = Database.executeBatch(bt);

 }
 
 }