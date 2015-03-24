public class SSEChatterList {
    
    public String mailingListName{set; get;}
    public String vfMailingListName{set; get;}
    public String memName { get; set; }
    public String finalList{set;get;}
    public boolean showFlag{get;set;}
    
    public SSEChatterList(){
        showFlag = false;
    }
    
    public PageReference addUser() {
        
        finalList = finalList+memName+',' ;
        memName ='';
       
        return null;
    }
    
    public PageReference SaveList() {
        
        vfMailingListName = mailingListName;
    
        Mailing_List__c m2 = new Mailing_List__c();
        m2.MailingListName__c = mailingListName;
        m2.Users__c = finalList;            
        try{
            insert m2;  
        }catch(Exception e){
        
        }    
        showFlag = true;
        
        mailingListName = '';
        finalList='';
        
        
        return null;
    }

    
}