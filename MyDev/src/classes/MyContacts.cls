public class MyContacts {

Contact c=new Contact();

    public String Phone1 { get; set; }

    public String LastName1 { get; set; }

    public String FirstName1 { get; set; }

    public MyContacts() {

    }


    
   public PageReference save()
    {
    
    c.FirstName=FirstName1;
    c.LastName=LastName1;
    c.Phone=Phone1;
    
    insert(c);
    String id =[select c1.id from Contact c1 where FirstName=:c.FirstName].id;
    PageReference page= new pageReference('https://c.ap1.visual.force.com/'+id);
    return page;
    
    
    

    }

}