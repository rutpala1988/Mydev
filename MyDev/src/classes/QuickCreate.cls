public with sharing class QuickCreate {

public String acctname{get;set;}

public Account a{get;set;}
public List<Contact> conList{get;set;}
public Task t{get;set;}

public Contact c1,c2,c3;

public QuickCreate()
{

 a=new Account();
 c1=new Contact();
 c2=new Contact();
 c3=new Contact();

conList=new List<Contact>();
conList.add(c1);
conList.add(c2);
conList.add(c3);
t=new Task();


}

public PageReference Submit()
{
 

  
  
  insert a;
  
  c1.AccountId=c2.AccountId=c3.AccountId=a.id;
  
  insert conList;
  
  t.Type='Call';
  t.Status='Completed';
  
  
  t.whatId=a.Id;
  
  for(integer i=0;i<conList.size();i++)
  {
  if(i==conList.size()-1)
  t.whoId=t.whoId+','+conList[i].id;
  else if(t.whoid!=null)
  t.whoid+=conList[i].id+',';
  else
  t.whoid=conList[i].id;
  }

  insert t;
  
  return new PageReference('/'+a.id);
  


}


}