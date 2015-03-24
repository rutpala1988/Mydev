public class SOAIpLookup {

    public JobPostingCite__c jobSite {get;set;}
    public ApexPages.standardController controller {get;set;}
    public String ipaddress {get;set;}
    private StrikeIronInfo__c info {
        get{
            if (info == null) {
                info = [select userid__c,password__c from strikeironinfo__c limit 1];
            }
            return info;    
        }
        set;
    }
    
    public SOAIpLookup(ApexPages.StandardController stdController) {
        // constructor
        controller = stdController;
        this.jobSite = (JobPostingCite__c)stdController.getRecord();      
    }
    
    public PageReference strikeIronIpCheck(){
        // Create the stub
        StrikeIronIPLookup.IPAddressLookupSoap dns = new StrikeIronIPLookup.IPAddressLookupSoap();

        // Set up the license header
        dns.LicenseInfo = new strikeiron.LicenseInfo();
        dns.LicenseInfo.RegisteredUser = new strikeiron.RegisteredUser();
        dns.LicenseInfo.RegisteredUser.UserID = info.userid__c;
        dns.LicenseInfo.RegisteredUser.Password = info.password__c;
        // Make the Web service call
        StrikeIronIPLookup.SIWsOutputOfDNSInfo info = dns.DNSLookup(jobSite.URL__c);
        System.debug(info);
        ipaddress = info.ServiceResult.HostName;
        
        return null;
    }
}