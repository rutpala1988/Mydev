public class ConnectChatterRestAPIDemo 
{
public   FeedItem fi{get;set;}
public  String post{get;set;}

public ConnectChatterRestAPIDemo ()
{
  
  
}
  
  public  void createPost()
  {
  fi=new FeedItem();
  fi.Body=post;
  fi.parentId=UserInfo.getUserId();
  insert fi;
  }
  
  public   void  doAction()
  {
    String text2=post.subString(post.indexof(':'));
    System.debug('text is ---'+text2);
    String text=fi.body;
    text=text.SubString(1,3);
    Http h = new Http();
    HttpRequest req = new HttpRequest();
    String salesforceHost = System.Url.getSalesforceBaseURL().toExternalForm();
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
  

  String userProfileId=UserInfo.getUserId();
  
  Http h1 = new Http();
    HttpRequest req1 = new HttpRequest();
    req1.setEndpoint('https://ap1.salesforce.com' + '/services/data/v29.0/chatter/feeds/user-profile/'+userProfileId+'/feed-items');
    req1.setMethod('POST');
    //System.debug('-----sessionid is'+sessionId);
   
    req1.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
    System.debug('--------'+UserInfo.getSessionId());
    req1.setHeader('Content-Type', 'application/json');
    req1.setBody('{ "body" : { "messageSegments" : [ { "type": "mention", "id" :"'+userId+'"}, { "type": "text",  "text" :"'+text2+'" } ] } }');
   HttpResponse res1 = h1.send(req1);
   
   List<feedItem> filIst=[select Id,Body from FeedItem where LastModifiedDate>=:System.Today() order by LastModifiedDate limit 2];
  if(filIst.size()>1)
  
   delete fi;

  
  
  }





}