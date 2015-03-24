@isTest(SeeAllData=true)
public class Testmycontroller1 {


private static TestMethod void test1(){
string currentobject='Account';
List<string> currentfield=new List<string>();
string SelectedType='Custom Edit Page';

map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
map<string,schema.sobjectfield> fieldmap = describe.get(currentobject).getdescribe().fields.getmap();
            for(string fieldname:fieldmap.keyset())
                currentfield.add(fieldname);
mycontroller1 mc = new mycontroller1 ();
   mc.getobjects(); 
  // mc.getfields();
   mc.getTypeOfpage();
   mc.loadFields();     
   mc.setCurrentfield(currentfield); 
   mc.setCurrentobject(currentobject);   
   mc.setSelectedType(SelectedType);
   mc.generateCode(currentobject,currentfield);
   mc.generateCode1(currentobject,currentfield); 
   mc.generateCodeFinal();            
           
  }      
}