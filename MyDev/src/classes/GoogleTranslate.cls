public class GoogleTranslate
{
  public String text{get;set;}
  public String output{get;set;}
  public GoogleTranslate()
  {
  
  
  }
  
  public void CallGoogleTranslteApi()
  {
  
    String redirect_uri=EncodingUtil.urlEncode('https://www.googleapis.com/language/translate/v2?source=en&target=de&key=AIzaSyBbIG6ET-sAsmHs11wXirvN14rrkVJhh7A&q='+text,'UTF-8');
     HttpRequest request=new HttpRequest();
     request.setMethod('GET');
     request.setEndPoint('https://accounts.google.com/o/oauth2/auth?client_id=293473792670-u4mluk6eivp6k4prg92qq86mhmdpusac.apps.googleusercontent.com293473792670-6ko91imb1gd3h3mffs8fcmui58h0ljem.apps.googleusercontent.com&response_type=code&scope=email&redirect_uri='+redirect_uri);
     request.setHeader('Authorization','OAUTH '+UserInfo.getUserId());
     
     Http http=new Http();
     HttpResponse resp=http.send(request);
     JSONParser parser=Json.createParser(resp.getBody());
     while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'translations')) {
                // Get the value.
                parser.nextToken();
                parser.nextToken();
                // Compute the grand total price for all invoices.
                output=parser.getText();
            }
     
  }
 
}

}