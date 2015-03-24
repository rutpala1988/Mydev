public class testAtMention{

    @future (callout=true)
    public Static void insertAtMen(List<String> parts,String body,String id){
    
        String salesforceHost = System.Url.getSalesforceBaseURL().toExternalForm();
        String postStr = '{ "body" : { "messageSegments" : [ ';
        
        for(integer j=0;j< parts.size();j++){
            user u = [select id from user where name=:parts[j]];
            postStr = postStr+'{ "type": "mention", "id" : "';
            postStr = postStr + u.id + '"},';            
        }
        
        postStr = postStr + '{ "type": "text","text":" -'+body+'" } ] } }';    
        FeedItem fit = [select id,ParentId from FeedItem where id=:id]; 
        system.debug('-----------222222222222----------'+fit+'--------------'+salesforceHost);                
        String url =  salesforceHost + '/services/data/v27.0/chatter/feeds/user-profile/'+fit.ParentId+'/feed-items';
    
        Http http = new Http();    
        HttpRequest req = new HttpRequest();                
        req.setMethod('POST');
        req.setEndpoint(url);
        req.setHeader('Content-type', 'application/json');            
        req.setHeader('Authorization', 'OAuth ' + '00D90000000cNGZ!AREAQHrbTfQhsjUjPBi2yxsFuSUUgYyLQObOTaeCMBUE3HqyqoiLEUW7hGOaLwkI1V39d2zsjAje2zqyiV49.CW_JMccSxwZ');
        req.setBody(postStr);   
  
        HTTPResponse res = http.send(req);
        system.debug('-----------222222222222----------'+res); 
        system.debug('-----------222222222222----------'+id);
        FeedItem fi = [select id from FeedItem where id=:id];
        system.debug('-----------222222222222----------'+fi); 
        delete fi;
        
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Chatter Mailing List is created'));
        
        
    }

}