public class CalloutClass {
    public void getInfoFromExternalService() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('/services/data/v28.0/sobjects');
        req.setMethod('GET');
        Http h = new Http();
        try{
            HttpResponse res = h.send(req);
            
        }catch(Exception e){}    
        
    }
}