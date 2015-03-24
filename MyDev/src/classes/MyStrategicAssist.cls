public with sharing class MyStrategicAssist {

public blob doc1{get;set;}
public Document d;

    public PageReference submit() 
    {
    
      d=new Document();
      d.FolderId=UserInfo.getUserId();
      d.body=doc1;
      d.contentType='image/jpeg';
      d.Type='image/jpeg';
      d.name='Test'+Math.floor(Math.Random()*10)+1;
      insert d;
      
      
      
       return new PageReference('/apex/SSE_Stategi_Assit_Page1?did='+d.id);
    }


   

}