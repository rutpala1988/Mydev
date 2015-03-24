public with sharing class RedirectPage {

    public RedirectPage(ApexPages.StandardController controller) {

    }
    
    public PageReference doAction()
    {
      return new PageReference('/apex/Testpage2');
    }

}