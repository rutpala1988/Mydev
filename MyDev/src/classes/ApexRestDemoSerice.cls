@RestResource(urlMapping='/MyService/*')
global with sharing class ApexRestDemoSerice {
    
    @HttpGet
    global static Account doGet()
    {
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        
        String acctId= RestContext.request.params.get('Account');
        
        Account result=[select Id,Name,Phone from Account where Id=:acctId];
        return result;
        
    }
    
    @HttpPost
    
    global static String doPost(String name,String phone)
    {
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        Account acct=new Account();
        acct.Name=name;
        acct.Phone=phone;
        insert acct;
        return acct.Id;
    }
    
    

}