trigger chatterList on FeedItem (after insert) {
    for(FeedItem fi : Trigger.new){
    
    String body = fi.body;
    
        if(body.containsAny('#')){
        
            
            integer firstOccr = body.indexOf('#');
            integer firstOccrSpace = body.indexOf(' ',firstOccr);
            String hashTag = body.substring(firstOccr,firstOccrSpace);
            
            Mailing_List__c mlc = [select id,Users__c from Mailing_List__c where MailingListName__c=:hashTag];
            system.debug('-----------1111111111----------'+mlc);
            if(mlc != null){
            
               List<String> parts = mlc.Users__c.split(',');                              
                    testAtMention.insertAtMen(parts,body,fi.id);                           
            }
            
            
        }
    
    }
}