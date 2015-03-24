public class MyContactExtension1
{


public String con{get;set;}
List<Contact> contlist;
List<Contact> searchList;
List<List<Sobject>> results;
   
public MyContactExtension1() {

    }
     public PageReference getAccountPage()
     {
     
     Account acc=[select id from Account where id=:ApexPages.currentPage().getParameters().get('id')];
     PageReference page=new PageReference('https://c.ap1.visual.force.com/'+acc.id);
     return page;
     }
     public PageReference getContactPage()
     {
     
     Contact con=[select id from Contact where id=:ApexPages.currentPage().getParameters().get('id1')];
     PageReference page=new PageReference('https://c.ap1.visual.force.com/'+con.id);
     return page;
     }

public String getCon()
{
return con;
}

 public List<Contact> getContact()
 {
  if(con==null)
  {
  contlist=[select Contact.LastName,Contact.Title,Contact.Phone,Contact.Account.Name from Contact limit 10];
  return contlist;
  }
  
  else{
  searchList=getContact1();
  return searchList;
  }
  
 }

  public List<List<Sobject>> getResults()
  {
  return results;
  }
  public PageReference find()
  {
    results=[FIND :con IN ALL FIELDS RETURNING Contact(LastName,Account.Name,Title,Phone) ];
     searchList=(List<Contact>)results[0];
     
    return null;
    
  }
   public List<Contact> getContact1()
 {
  
  return searchList;
  
 }
  public PageReference save()
  {
  PageReference ref;
  update contlist;
  ref=new PageReference('https://ap1.salesforce.com/001/o');
  return ref;
}

//test methods
 public static testmethod void getData()
 {
   MyContactExtension1 myCon=new MyContactExtension1();
   myCon.getContact();
   myCon.find();
   myCon.getResults();
   myCon.getContactPage();
   myCon.getAccountPage();
 }
}