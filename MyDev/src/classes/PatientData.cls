global with sharing class PatientData {
public String imgid { get; set; }
public static String imgid1{get;set;}
public  boolean show{get;set;}
public Static String pd{get;set;}
public List<Patient__c> plist1{get;set;}
public List<Patient__c> plist{get;set;}

  public PatientData()
  {  plist=[select FirstName__c,LastName__c,TimeSlot__c,ProviderName__r.Name from Patient__c];
  
    
  
  } 
  
  
    public PageReference getData() {
    String pid=ApexPages.currentPage().getParameters().get('pid');
    Attachment att=[select id,Name from Attachment where parentId=:pid];
       imgid1=att.id;
    System.debug('pid is'+pid);
    plist1=[select FirstName__c,LastName__c,TimeSlot__c,ProviderName__r.Name from Patient__c where id=:pid];
    
        return null;
    }
    
    @RemoteAction
    global static void getPatient(String pid)
    {
       pd=pid;
       System.debug('----------'+pd);
       
      
    }
  
  

}