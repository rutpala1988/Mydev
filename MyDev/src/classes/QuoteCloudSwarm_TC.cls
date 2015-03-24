@isTest(SeeAllData=true)
        public class QuoteCloudSwarm_TC
        {
        
          public static  testMethod void QuoteMethod()
            {
               Opportunity opp=[Select Id,Name from Opportunity limit 1];
               Quote q=new Quote();
               q.Name='Testing';
               q.Status='In Review';
               q.OpportunityId=opp.Id;
               insert q;
               EntitySubscription es1=new EntitySubscription();
               es1.ParentId=q.Id;// Parent Id should point to the Quote Id
               es1.SubScriberId='005900000012kGM';
        
        
            }
        
        
        
     }