public class Campaigns {

    public String items { get; set; }

    public String[] getTheater() {
        return Theater;
    }


    public String[] Theater=new String[]{};
    
    
    public void setTheater(String[] Theater)
         {
    
             this.Theater=Theater;   
       
         }
         
         public List<SelectOption> getItems()
         {
         
           List<SelectOption> options=new List<SelectOption>();
           options.add(new SelectOption('APJ','APJ'));
           options.add(new SelectOption('EMEA','EMEA'));
           options.add(new SelectOption('AMER','AMER'));
       
            return options;
    
         }
    
       }