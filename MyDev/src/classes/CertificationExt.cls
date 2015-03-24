public with sharing class CertificationExt
{
public String select1{get;set;}
public List<SelectOption> options{get;set;}
public CertificationExt(ApexPages.StandardController controller)
{

 options=new List<SelectOption>();
 options.add(new SelectOption('ADM201','ADM201'));
 options.add(new SelectOption('DEV401','DEV401'));
 options.add(new SelectOption('DEV501','DEV501'));
 
}
public List<SelectOption> getOption()
{
  return options;

}



}