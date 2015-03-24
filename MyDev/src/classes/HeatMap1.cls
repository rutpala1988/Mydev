public class HeatMap1
{

 List<Account> dps=new List<Account>();

 List<Account> acctList;
 
 
 
 
 public List<Account> getListAccounts()
 {
  
   acctList=[SELECT Description, Fax, Id, Name, AccountNumber, Phone, Rating, Site, Type, Active__c, AnnualRevenue, Apex_Video__c, BillingCity, BillingCountry, BillingState, BillingStreet, BillingPostalCode, CreatedById, CreatedDate, CustomerPriority__c, IsDeleted, NumberOfEmployees, Industry, LastActivityDate, LastModifiedById, LastModifiedDate, MasterRecordId, NumberofLocations__c, OwnerId, Ownership, ParentId, RecordTypeId, Sic, SLA__c, SLAExpirationDate__c, SLASerialNumber__c, ShippingCity, ShippingCountry, ShippingState, ShippingStreet, ShippingPostalCode, SystemModstamp, Theatre__c, TickerSymbol, UpsellOpportunity__c, Warranty__c, Website FROM Account limit 10];
   return acctList;

}

 public PageReference getCasePage()
     {
      Case c=[select id from Case where id=:ApexPages.currentPage().getParameters().get('newid')];
     PageReference page=new PageReference('https://na15.salesforce.com/apex/CaseDisplay?id='+c.id);
     return page;
     }

}