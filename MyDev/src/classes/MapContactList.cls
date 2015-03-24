public with sharing class MapContactList {

public List<SelectOption> options{get;set;}
public List<OpportunityContactRole> cList{get;set;}
public List<Contact> contactList{get;set;}
public String opt1;
public String opt2{get;set;}
public List<SelectOption> options1{get;set;}

public List<String> cnameList=new List<String>();

public Set<ID> cids{get;set;}

public List<OpportunityTeamMember> optMember{get;set;}


public String getOpt1()
{

return opt1;
}

public void setOpt1(String name)
{
 opt1=name;
 cnameList.add(opt1);

}

public MapContactList(ApexPages.StandardController controller)
{
cids=new Set<ID>();
ContactList=new List<Contact>();
cList=[SELECT ContactId,Contact.Name,Role,Contact.Account.Name,Contact.Email,Contact.Phone,OpportunityId FROM OpportunityContactRole where OpportunityId=:ApexPages.currentPage().getParameters().get('id') ];

for(OpportunityContactRole op:cList)
{
cids.add(op.ContactId);

}
options=new List<SelectOption>();


optMember=[SELECT OpportunityId,UserId ,User.Name FROM OpportunityTeamMember where OpportunityId=:ApexPages.currentPage().getParameters().get('id') ];

options1=new List<SelectOption>();

for(OpportunityTeamMember op: optMember)
{
options1.add(new SelectOption(op.User.Name,Op.User.Name));

}

}

public void doSave()
{

List<Contact> conList=[select Id,Name from COntact where Id in :cids];
List<OpportunityTeamMember> optList=[SELECT OpportunityId,UserId ,User.Name FROM OpportunityTeamMember where User.Name in : cnameList];
List<MapContact2Team__c> mapct=new List<MapContact2Team__c>();

for(integer i=0;i<conList.size();i++)
{
MapContact2Team__c mapc=new MapContact2Team__c();
mapc.Contact__c=conList[i].Id;
mapc.TeamMember__c=optList[i].UserId ;
mapc.Opportunity__c=optList[i].OpportunityId;
mapct.add(mapc);



}

insert mapct;


}

}