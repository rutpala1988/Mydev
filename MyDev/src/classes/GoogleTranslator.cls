public with sharing class GoogleTranslator
{
public String source{get;set;}
public HttpResponse res {get;set;}
public String resp{get;set;}

  public PageReference getTranslatedText()
  {
    HttpRequest req=new HttpRequest();
    req.setMethod('GET');
    req.setEndPoint('https://www.googleapis.com/language/translate/v2?key=AIzaSyBqsfC1vsSXp0lp6knvkblnkvZXzFNvotM&source=ja&target=en&q='+source);
    resp='';
    Http http=new Http();
    res=http.send(req);
    JSONParser parser = JSON.createParser(res.getBody());
   while (parser.nextToken() != null) {
    //if current token is a field name

    if (parser.getCurrentToken() == JSONToken.FIELD_NAME){

        String fieldName = parser.getText();

        System.debug('fieldName: ' + fieldName);

        //move to token after the field name

        parser.nextToken();
        resp=parser.getText();

            
            
        
  
  
  }

 }
   return new PageReference(resp);  

}

}