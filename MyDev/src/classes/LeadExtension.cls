public class LeadExtension
{
public Lead l;
public String lName{get;set;}
public String lStatus{get;set;}
public String lEmail{get;set;}
public String lPhone{get;set;}

public LeadExtension(ApexPages.StandardController stdcontroller)
{
l=(Lead)stdcontroller.getRecord();
}

public PageReference next()
{

PageReference ref=new PageReference('https://c.ap1.visual.force.com/apex/CasePage?lName='+lName+'&lEmail='+lEmail+'&lPhone='+lPhone+'&lStatus='+l.status);
return ref;
}
}