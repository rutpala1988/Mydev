public Class ChatterRestAPI
{

@future(callout=true) public static void invokeMethod(String quoteId)
{


 String salesforceHost = System.Url.getSalesforceBaseURL().toExternalForm();
        
String url =  salesforceHost + '/services/data/v28.0/chatter/feeds/record/' + quoteId + '/feed-items';
            
String UserId='005900000012kGH';
HttpRequest req = new HttpRequest();
String chatterAlert='GE Drilling is happy to accept your RFQ. We will be reviewing the details and providing you with timely updates.';
            
req.setMethod('POST');
req.setEndpoint(url);
req.setHeader('Content-type', 'application/json');
req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
            
req.setBody('{ "body" : { "messageSegments" : [ { "type": "mention", "id" : "' + UserId + '" }, { "type": "text",  "text" : "' + ' ' + chatterAlert +  '" } ] } }');
Http http = new Http();
  
HTTPResponse res = http.send(req);

}


}