@isTest
public class MyContactExtension1_TC
{

  public String con='Semantago';
  
  public static testmethod void getData()
  {
    MyContactExtension1 conext=new MyContactExtension1();
    List<Contact> conList=new List<Contact>();
    conList=conext.getContact();
    
    
  
  }

}