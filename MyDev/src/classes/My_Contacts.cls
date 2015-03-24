public class My_Contacts
{

 public  boolean myCheckBox;
  
  public boolean getMyCheckBox()
  {
  return myCheckBox;
  }
    
  
    
    public void setMyCheckBox(boolean checkbox)
    {
     this.myCheckBox=checkbox;
     }
    
List<Contact> contacts;

public List<Contact> getContacts()
{
 contacts=[select FirstName,LastName,Phone from Contact];
 return contacts;
 
}

List<Contact> delContacts=new List<Contact>();

public void  deleteContact() 
{

for(Contact c:contacts)
{

if(myCheckBox==true)
{
System.debug('+++++++++++++++'+myCheckBox);
delContacts.add(c);
}
}
delete delContacts;

 
}
}