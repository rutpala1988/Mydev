global with Sharing class MyContactForAccount
{
webService static List<Contact> getContacts(Id id)
{
     List<Contact> conts=[select FirstName From Contact c where c.AccountId=:id];
       
       return conts;
       
 }
}