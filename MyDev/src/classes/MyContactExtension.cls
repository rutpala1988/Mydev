public class MyContactExtension
{
 Contact con;
 List<Contact> contlist;
public MyContactExtension(ApexPages.StandardController stdcontroller)
{
con=(Contact)stdcontroller.getRecord();

}

 public List<Contact> getContact()
 {
  contlist=[select Contact.LastName,Contact.Title,Contact.Phone from Contact limit 5];
  return contlist;
  
 }

  
  public List<List<Sobject>> find()
  {
    List<List<Sobject>> searchList=[FIND '{!contact.LastName}' IN ALL FIELDS RETURNING Contact(LastName,Title,Phone)];
    return searchList;
    
  }
}