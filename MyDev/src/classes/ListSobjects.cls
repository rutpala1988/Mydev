public with sharing class ListSobjects {
public String opt{get;set;}

public List<SelectOption> options{get;set;}
public Map<String, Schema.SObjectType> gd;
public ListSobjects()
{
 gd = Schema.getGlobalDescribe(); 
options=new List<SelectOption>();
for(Schema.SObjectType d:gd.values())
{

   Schema.DescribeSObjectResult ds = d.getDescribe();
   options.add(new SelectOption(ds.getName(),ds.getName()));

}

}

public pagereference autoFollow()
{
   HttpRequest req = new HttpRequest();
   
   
   String semicolon=';';
  soapSforceCom200608Apex.Apex sf=new soapSforceCom200608Apex.Apex();
  String triggerquery='trigger AutoFollowRecord'+opt.replace('__c','')+' on '+opt+'(after insert,after update){\n';
  
     triggerquery+='for('+opt+' obj:Trigger.New)\n';
     triggerquery+='{\n';
        triggerquery+='EntitySubScription sub =new EntitySubScription()';
        triggerquery+=semicolon+'\n';
        triggerquery+='sub.ParentId=obj.Id';
        triggerquery+=semicolon+'\n';
        triggerquery+='sub.SubScriberId=UserInfo.getuserId()';
        triggerquery+=semicolon+'\n';
        triggerquery+='insert sub';
        triggerquery+=semicolon+'\n';
        triggerquery+='}\n';
        triggerquery+='}';
        List<String> StringArray=new List<String>{};
        StringArray.add(triggerquery);

     
     soapSforceCom200608Apex.SessionHeader_element header=new soapSforceCom200608Apex.SessionHeader_element();
     
     
      header.sessionId=UserInfo.getSessionId();
      
      sf.SessionHeader=header;
      
      System.debug('Session Id-----'+sf.SessionHeader.sessionId);
      
     
      
      
     
  soapSforceCom200608Apex.CompileTriggerResult[] result=sf.compileTriggers(StringArray);
  
  return new pagereference('/'+result[0].id);
  
  //System.debug('Result is-----'+result);
  
  
  
  
  
  
  


}


}