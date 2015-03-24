public class TestNYLWebService
{
  public wsCrmNylCom  nylc{get;set;}
  public  wsCrmNylCom.account acct{get;set;}
  public  wsCrmNylCom.request req{get;set;}
  public   wsCrmNylCom.response resp{get;set;}
  public   wsCrmNylCom.TransactionsHistoryServicePort txn{get;set;}
  public  String result {get;set;}
  public TestNYLWebService()
  {
     nylc =new wsCrmNylCom();
     acct=new wsCrmNylCom.account();
     acct.admSysCd=''+Math.round(Math.random()*100)+1;
     acct.number_x=''+Math.round(Math.random()*100)+1;
     req=new wsCrmNylCom.request();
     resp=new wsCrmNylCom.response();
     req.account=acct;
     txn=new wsCrmNylCom.TransactionsHistoryServicePort();
     txn.getTransactionsHistory(req);
     System.debug('Response is'+resp);
  
  }
  
}