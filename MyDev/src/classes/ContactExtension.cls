public class ContactExtension
{

String url;
Contact con;
public ContactExtension(ApexPages.StandardController stdcontroller)
{
con=(Contact)stdcontroller.getRecord();
}

public String getUrl()
{
 return ApexPages.currentPage().getURL();
} 


public PageReference pdfGenerate()
{
 
 String returnURL=ApexPages.currentPage().getParameters().get('Id');
 String reqId=returnURL.subString(returnURl.lastIndexOf('/')+1);
 PageReference ref=new PageReference('https://c.ap1.visual.force.com/apex/ContactPDFGenerator1'+'?id='+returnURL);
 return ref;

}
}