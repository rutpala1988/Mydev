@isTest
public class CaseListController_TC
{
  public List<Case> caseList=new List<Case>();
  
  public static testmethod void getData()
  {
  
  CaseListController cl=new CaseListController();
  cl.getCase();
  
  }
  


}