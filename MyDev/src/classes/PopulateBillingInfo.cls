public class PopulateBillingInfo
{
 public Account act{get;set;}
 
 public PopulateBillingInfo(ApexPages.StandardController controller)
 {
 
      act=(Account)controller.getRecord();
 }   
 
 public Account getAct()
 {
  System.debug('parent id is '+act.parentid);
  
  if(act.parentid!=null)
  {
  Account a=[select account.BillingCountry,account.BillingState,account.BillingStreet from account where id =:act.parentid];
  return a;
  }
  else
  {
  return null;
  } 
  
 }
 


}