public class DynamicSectionHeader
{
  date deadLine=date.newInstance(2012,12,03);
  
  
  public DynamicSectionHeader(ApexPages.StandardController controller)
  {
        
  }
  
  public Component.Apex.SectionHeader  getDueDate()
  {
  
  boolean overdue=date.today().daysBetween(deadLine)< 0;
  
  if(overdue)
  {
  
    Component.Apex.SectionHeader header=new Component.Apex.SectionHeader();
    header.title='Due date to submit the form is'+deadLine.format();
    return header;
  
  }
  
  else
  {
   
  Component.Apex.SectionHeader header=new Component.Apex.SectionHeader();
  header.title='Form Submission';
  return header;
  }

}


}