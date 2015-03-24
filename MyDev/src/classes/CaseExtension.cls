public class CaseExtension
{
public Case c;
public User ownerid{get;set;}
public String subject{get;set;}
public String priority{get;set;}
public String reason{get;set;}

public CaseExtension(ApexPages.StandardController stdcontroller)
{
c=(Case)stdcontroller.getRecord();
}
public PageReference save()
{
 
 String lName=ApexPages.currentPage().getParameters().get('lName');
 System.debug('Lead Fisrt Name is+++++++++++'+lName);
 String lStatus=ApexPages.currentpage().getParameters().get('lStatus');
 System.debug('Lead Fisrt Name is+++++++++++'+lStatus);
 String lEmail=Apexpages.currentPage().getParameters().get('lEmail');
 System.debug('Lead Fisrt Name is+++++++++++'+lEmail);
 String lPhone=ApexPages.currentPage().getParameters().get('lPhone');
 System.debug('Lead Fisrt Name is+++++++++++'+lPhone);
 Lead l=new Lead(LastName=lName,Status=lStatus,Email=lEmail,Phone=lPhone,Company='Testing');
 Case c=new Case(Subject=c.subject,Reason=c.reason,Priority=c.Priority);
 insert l;
 insert c;

PageReference page=new PageReference('https://ap1.salesforce.com/'+c.id);
return page;
}
}