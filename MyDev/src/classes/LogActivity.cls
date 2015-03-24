global without sharing class LogActivity{
 public Task task{get;set;}
 public  String taskid {get;set;}
 Public String accid {get;set;} 
 public Database.Saveresult result{get;set;} 
  public  LogActivity(){
     task = new Task();
      accid= apexpages.currentpage().getparameters().get('accid');
  }
  

webservice static string  saveAcc(String recordId,String subject,String type,String comments){
     
     Database.Saveresult result;
    Task task = new Task();
     task.Whatid=recordId;
     task.Status = 'Completed';
      task.Type=type;
       
      task.Description =comments;
      task.ActivityDate = system.Today();
     if(subject==null || subject=='')
          task.Subject =type;
     else
         task.Subject=subject;
     
       result= database.insert(task);
     return result.id;
  }
      
   webservice static string savenviewAct(String recordId,String subject,String type,String comments ){
       // saveAcc(recordId,subject,type,comments,subtype);
    // Pagereference  p = new Pagereference ('/'+saveAcc(recordId,subject,type,comments,subtype));
     return saveAcc(recordId,subject,type,comments);
    
    }
}