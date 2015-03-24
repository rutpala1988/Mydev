public class ContactListView{

 public List<Contact> contactList{get;set;}
 public contact currentContact{get;set;}
  
  public List<Contact> getContacts(){
        
        contactList=[select Name,AccountId,Phone,Email from Contact limit 100];
        
        return contactList;
        
  
    }  
    
     public ContactListView(ApexPages.StandardController controller) {
    currentContact=(Contact)controller.getRecord();
    System.debug('Contact Id is---'+currentContact.Id);

    }
    
   public pagereference edit(){
      
      string Id=ApexPages.currentPage().getParameters().get('id');
      
      return new PageReference('/'+id+'/e?retURL=%2F'+id);
   
    } 
    
    
    public PageReference cancel() {
        return null;
    }


    public PageReference save() {
       List<Contact> contactList=new List<Contact>();
       contactList.add(currentContact);
        Database.update(contactList);
       return null;
    }



}