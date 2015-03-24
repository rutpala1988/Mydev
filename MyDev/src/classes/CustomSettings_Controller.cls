public class CustomSettings_Controller
{

public Map<String,Country__c> countries {get;set;}

public CustomSettings_Controller()
{
 countries =new Map<String,Country__c>();
 countries=Country__c.getAll();
 
System.debug('Map is ---'+countries);

System.debug('Value for Australia is---'+countries.get('Australia'));
  

}


}