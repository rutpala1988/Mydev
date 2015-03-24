public with sharing class Crodoc
{
public HttpResponse res {get;set;}
public String resp{get;set;}

  public PageReference getDoc()
  {
    HttpRequest req=new HttpRequest();
    req.setMethod('POST');
    req.setEndPoint('https://crocodoc.com/api/v2/session/create');
    req.setHeader('Content-Type','application/json');
    req.setBody('token=uZa85e6BzTmEbY1VK4pFnDNX&uuid=544fb886-e9d7-4fb0-bc0d-83f703383b72&editable=true&user=1,Username&downloadable=true');
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
   return new PageReference('https://crocodoc.com/view/'+resp);  

}

}