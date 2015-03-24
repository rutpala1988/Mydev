trigger AfterQuoteLineItemInsert on QuoteLineItem (after insert) {


for(QuoteLineItem q1: Trigger.New)
{

    // Get the Quote on which LineItems needs to be adjusted.
     Quote q=[SELECT AdditionalCity, AdditionalCountry, AdditionalName, AdditionalState, AdditionalStreet, AdditionalPostalCode, BillingCity, BillingCountry, BillingName, BillingState, BillingStreet, BillingPostalCode, ContactId, CreatedById, CreatedDate, IsDeleted, Description, Discount, Email, ExpirationDate, Fax, GrandTotal, LastModifiedById, LastModifiedDate, LineItemCount, OpportunityId, Phone, Pricebook2Id, Id, Name, QuoteNumber, QuoteToCity, QuoteToCountry, QuoteToName, QuoteToState, QuoteToStreet, QuoteToPostalCode, ShippingCity, ShippingCountry, ShippingName, ShippingState, ShippingStreet, ShippingPostalCode, ShippingHandling, Status, Subtotal, IsSyncing, SystemModstamp, Tax, TotalPrice FROM Quote where id=:q1.QuoteId];
 
   // Get the Opportunity for which Quote is being created.
     Opportunity oppty=[SELECT Id,AccountId  from Opportunity where Id=:q.OpportunityId];
  
    
     //Get the list of Products for the Opportunity
     List<OpportunityLineItem> opptylineitemList=[SELECT  OpportunityId, PricebookEntryId FROM OpportunityLineItem where OpportunityId=:oppty.Id];
     
     
     
     //Get the set of PriceBookEntryIds for the above products
     Set<ID> PriceBookEntryIds=new Set<ID>();
     for(OpportunityLineItem oppline:opptylineitemList)
     {
     PriceBookEntryIds.add(oppline.PricebookEntryId);
     
     }
     
     //Here the Criteria goes .
     //In this case the requirement is to display all the products in the Quote except for the prodcuts made in china.
     // So we are selecting the products made in china and deleting these products from QuoteLineItems.
      List<Product2> prodList=[SELECT  Id FROM Product2 where Product_Made_In__c='China'];
      Set<ID> Pids=new Set<ID>();
      
      for(Product2 p:prodList)
      {
        Pids.add(p.Id);
      }
      
     
      //Getting the set of PriceBookEntryIds which are mapped to Products made in china.
      List<PricebookEntry> deletePricebookEntryList=[SELECT IsActive, CreatedById, CreatedDate, IsDeleted, LastModifiedById, LastModifiedDate, UnitPrice, Id, Pricebook2Id, ProductCode, Product2Id, Name, SystemModstamp, UseStandardPrice FROM PricebookEntry where Product2Id in :Pids and Id in :PriceBookEntryIds ];
  
      Set<ID> deletePriceBookIds=new Set<ID>();
      
      for(PricebookEntry pe1:deletePricebookEntryList)
      
      {
        deletePriceBookIds.add(pe1.id);
      
      }
      
      
      //Here we are deleting the QuoteLineItems where PriceBookEntry contains the Products made in China
      List<QuoteLineItem> qoteLineitem=[SELECT  PricebookEntryId, Quantity, QuoteId, Id, UnitPrice, TotalPrice FROM QuoteLineItem where PricebookEntryId in :deletePriceBookIds];
      delete qoteLineitem;
      
      
  
  

}

}