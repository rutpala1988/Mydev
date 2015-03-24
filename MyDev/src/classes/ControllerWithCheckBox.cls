public class ControllerWithCheckBox
{
 public List<Account> acctList{get;set;}
 public List<AccountWrapper> acctWrapperList{get;set;}
  public List<Account> acctListFinal{get;set;}
  public boolean disp{get;set;}
 
 public ControllerWithCheckBox()
 {
 acctList=[Select Name,Phone from Account limit 10];
 acctWrapperList=new List<AccountWrapper>();
 for(Account a:acctList)
 {
 AccountWrapper acctWrap=new AccountWrapper(a.name,a.phone,a.id);
 
 acctWrapperList.add(acctWrap);
 
 
 }
 
 
 
 }
 
 public List<AccountWrapper> getAccounts()
 {
   return acctWrapperList;
 
 }
 

 
 public PageReference getSelectedValues()
 {
   Set<ID> acctIds=new Set<ID>();
   for(AccountWrapper acctWrap:acctWrapperList)
   {
     if(acctWrap.check==true)
     {
      acctIds.add(acctWrap.recordId);
     
     }
   
   
   }
   acctListFinal=[Select Name,Phone from Account where Id in :acctIds];
   disp=true;
   return null;
 
 }
 
 public List<Account> getSelectedAccounts()
 {
   return acctListFinal;
 
 
 }

 
 public class AccountWrapper
 {
 public boolean check{get;set;}
 public String recordId{get;set;}
 public String acctName{get;set;}
 public String phone{get;set;}
 
 public AccountWrapper(String acctName,String phone,String recordId)
 {
 this.acctName=acctName;
 this.phone=phone;
 this.recordId=recordId;
 
 
 }
 
 }



}