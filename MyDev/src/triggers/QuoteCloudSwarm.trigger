trigger QuoteCloudSwarm on Quote (after insert,after update) {

    for(Quote q:Trigger.New){
                    
      if(q.Status=='In Review') // set the condition for the quote to be followed
      {
        
        // Here is an exmple where Quote is followed by two users
        
        
        EntitySubscription es=new EntitySubscription();
        es.ParentId=q.Id;// Parent Id should point to the Quote Id
        
        es.SubScriberId='005900000012kGH';// id of the user to follow the quote
        
        insert es;
        
        
        EntitySubscription es1=new EntitySubscription();
        es1.ParentId=q.Id;// Parent Id should point to the Quote Id
        
        es1.SubScriberId='005900000012kGM'; // id fo the user to follow the quote
        
        insert es1;
        }



   }

}