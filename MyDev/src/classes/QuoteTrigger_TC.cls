@isTest (seeAllData=true)
public class QuoteTrigger_TC
{

  public static testMethod  void  testQuote()
  {
     
  
  
  /* List<OpportunityLineItem> ProdList=[SELECT Id,OpportunityId,PriceBookEntryId FROM OpportunityLineItem where OpportunityId!=null  limit 1];
    Opportunity oppty=[select Id from Opportunity where Id=:ProdList[0].OpportunityId ];
    Quote q=new Quote();
    q.name='Testing';
    q.OpportunityId=oppty.Id;*/
    
    Opportunity opp=new Opportunity();
    opp.Name='Testing';
    opp.StageName='New';
    opp.CloseDate=System.today()+120;
    
    insert opp;
    
    List<Product2> products=[select Id,Name,Product_Made_In__c from Product2 where Product_Made_In__c='China'];
    List<PriceBookEntry> pbentry=[SELECT IsActive, CreatedById, CreatedDate, IsDeleted, LastModifiedById, LastModifiedDate, UnitPrice, Id, Pricebook2Id, ProductCode, Product2Id, Name, SystemModstamp, UseStandardPrice FROM PricebookEntry where Product2Id=:Products[0].Id]; 
    OpportunityLineItem opptProduct1=new OpportunityLineItem();
    opptProduct1.OpportunityId=opp.Id;
    //opptProduct1.ProductId=products[0].Id;
     opptProduct1.PricebookEntryId=pbentry[0].Id;
     opptProduct1.UnitPrice=100;
     OpptProduct1.Quantity=2;
     insert opptProduct1;
   
      Product2 p = new product2(name='unittest');
        p.Family = 'License';
        insert p;  
    
     List<Pricebook2> stdPb = [select Id from Pricebook2 where isStandard=true limit 1];
        
        if(stdPb[0].id != null){
        
          
     Quote q=new Quote();
    q.name='Testing';
    q.OpportunityId=opp.Id;
     q.Pricebook2Id = stdpb[0].id;
    //test.startTest();
    insert q;
    //test.stopTest();
        
            PricebookEntry pbe = new PricebookEntry(pricebook2id = stdPb[0].id, product2id = p.id,unitprice=1.0,isActive=true);
            insert pbe;
    
      quoteLineItem qli = new quotelineitem(); 
        qli.quoteid = q.id; 
        qli.pricebookentryid = pbe.id ;
        qli.quantity = 1; 
        qli.unitprice = 1; 
        Database.insert(qli); 
        
   
    
     List<QuoteLineItem> qoteLineitem=[SELECT  PricebookEntryId, Quantity, QuoteId, Id, UnitPrice, TotalPrice FROM QuoteLineItem where QuoteId=:q.Id and PricebookEntryId=:pbentry[0].Id];
      delete qoteLineitem;
      
    }
     
    
    
    
    
    
    
 }


}