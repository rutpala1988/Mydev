public with sharing class RecordTypeSelection {

    public RecordTypeSelection(ApexPages.StandardController controller) {

    }


    public List<SelectOption> opt{get;set;}

    public String recordtype { get; set; }
    
    public List<SelectOption> getOptions()
    {
       opt=new List<SelectOption>();
       opt.add(new SelectOption('Parent Account Record Type','Parent Account Record Type'));
       opt.add(new SelectOption('Patient','Patient'));
       return opt;
    
    }
    
    public pagereference nextStep()
    {
      
      if(recordType=='Parent Account Record Type')
      
      return new Pagereference('https://ap1.salesforce.com/001/e?retURL=%2F001%3Ffcf%3D00B90000003BF9l%26rolodexIndex%3D-1%26page%3D1&RecordType=012900000007gxE&ent=Account');
      
      else 
      
      return new Pagereference('/apex/PatientPage');
    
    }
    
    public pagereference cancel()
    {
      return null;
    }
    
}