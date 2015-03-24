public class CaseListController
{

List<Case> caseList=[select Case.CaseNumber,Case.Subject,Case.Status from Case limit 5];

public List<Case> getCase()
{
return caseList;
}

public PageReference Save()
{
PageReference pageref;
update caseList;
pageref=new PageReference('https://ap1.salesforce.com/500/o');
return pageref;
}
}