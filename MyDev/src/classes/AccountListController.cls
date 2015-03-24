public class AccountListController {


     
    public List<Account> account=[select id,name,phone,Owner.Email,Active__c,Theatre__c from Account];
  
    
    public List<Account> getAccount() {
        return account;
    }
     public PageReference getAccountPage()
     {
     
     Account acc=[select id from Account where id=:ApexPages.currentPage().getParameters().get('id')];
     PageReference page=new PageReference('https://c.ap1.visual.force.com/'+acc.id);
     return page;
     }
}