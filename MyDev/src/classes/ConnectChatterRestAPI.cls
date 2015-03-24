public class ConnectChatterRestAPI 
{
public  FeedItem fi{get;set;}

public ConnectChatterRestAPI ()
{

}
  
  public void createPost()
  {
  fi=new FeedItem();
  fi.Body='@Howe Tim';
  fi.parentId=UserInfo.getUserId();
  insert fi;
  
  }
  
  public   void  doAction()
  {
    String text=fi.Body;
    text=text.SubString(1,3);
    Http h = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint('https://ap1.salesforce.com' + '/services/data/v29.0/chatter/mentions/completions?q='+text);
    req.setMethod('GET');
    req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
    req.setHeader('Content-Type', 'application/json');
   
    HttpResponse res = h.send(req);
  JSONParser parser=JSON.createParser(res.getBody());
  string userid;
  while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'recordId')) {
                // Get the value.
                parser.nextToken();
                // Compute the grand total price for all invoices.
                userid= parser.getText();
                
            }
        }
  

  
  
  Http h1 = new Http();
    HttpRequest req1 = new HttpRequest();
    req1.setEndpoint('https://ap1.salesforce.com' + '/services/data/v28.0/chatter/feeds/user-profile/005900000012kGH/feed-items');
    req1.setMethod('POST');
    //System.debug('-----sessionid is'+sessionId);
    ProcessController.control=true;
    req1.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
    System.debug('--------'+UserInfo.getSessionId());
    req1.setHeader('Content-Type', 'application/json');
    req1.setBody('{ "body" : { "messageSegments" : [ { "type": "mention", "id" : "' + userid+ '" }, { "type": "text",  "text" : "How about DF 2013 prep deck" } ] } }');
   HttpResponse res1 = h1.send(req1);
   
   delete fi;
  
  
  }





}