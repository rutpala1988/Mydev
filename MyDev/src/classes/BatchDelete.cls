global Class BatchDelete implements Database.Batchable<sobject>
{

  public String query;
  
  global Database.QueryLocator start(Database.BatchableContext bc)
  {
  
       return Database.getQueryLocator(query);
  
  }
  
  
  global  void execute(Database.BatchableContext bc,List<sobject> scope)
  {
   
    delete scope;
    Database.emptyRecycleBin(scope);
     
  
  }

  global void finish(Database.BatchableContext bc)
  {
  
  
  }


}