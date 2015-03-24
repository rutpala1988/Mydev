public class CustomSettingRead
{
public String text{get;set;}

public void doAction()
{
  List<GoogleAPI__c> mcs = GoogleAPI__c.getall().values();
    text=mcs[0].API_Key__c;
   System.debug('---'+text);

}

}