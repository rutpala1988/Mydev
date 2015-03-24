public class SendMessageRestAPI

{
 public HttpResponse res{get;set;}

  public void sendMessage()
  
  {
  
     try
     {
    HttpRequest req=new HttpRequest();
    req.setEndPoint('https://api.plivo.com/v1/Account/MAZJFJYWQ0OTK0ZME5YM/Message/');
    String username='rutpala';
    String password='Ramabala@1987';
    Blob headerValue = Blob.valueOf('MAZJFJYWQ0OTK0ZME5YM'+ ':' + 'NTljZmQyMjBiN2QzYzYxYTgzNjQzODg4NDdmM2Zm');
    String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
    req.setHeader('Authorization', authorizationHeader);
    req.setMethod('POST');
    req.setHeader('Content-Type','application/json');
    req.setBody('{src:918886526611,dest:919866917525,text:"Sample Message"}');
    Http http=new Http();
    res=http.send(req);
    System.debug('Response is ----'+res);
    }
    catch(Exception e)
    {
      System.debug('Exception is'+e.getMessage());
    
    }
    
  }





}