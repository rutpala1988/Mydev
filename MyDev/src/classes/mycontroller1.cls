public class mycontroller1 {

        public string currentobject { get; set; }
        public List<string> currentfield { get; set; }
        public string SelectedType{ get; set; }
        String code{get;set;}
        String code1='';
        String output='';
        
    public mycontroller1(){
    }
    
    public selectoption[] getobjects() {
        selectoption[] objects = new selectoption[0];
        objects.add(new selectoption('--None--','--None--'));
        map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
        for(string objectname:describe.keyset()) {
            objects.add(new selectoption(objectname,describe.get(objectname).getdescribe().getname()));
        }
      //  system.debug('=============objects=============='+objects);
        return objects;
       
    }
    
    public selectoption[] getfields() {
        selectoption[] fields = new selectoption[0];
        map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
        if(describe.containskey(currentobject)) {
            map<string,schema.sobjectfield> fieldmap = describe.get(currentobject).getdescribe().fields.getmap();
            for(string fieldname:fieldmap.keyset()) {
                fields.add(new selectoption(fieldname,fieldmap.get(fieldname).getdescribe().getname()));
            }
        }
        return fields;
    }
    
     public selectoption[] getTypeOfpage() {
        selectoption[] type= new selectoption[0];
        type.add(new SelectOption('Standard Edit Page','Standard Edit Page'));
        type.add(new SelectOption('Standard Detail Page','Standard Detail Page'));
        type.add(new SelectOption('Custom Edit Page','Custom Edit Page'));
        type.add(new SelectOption('Custom Detail page','Custom Detail page'));
    //    type.add(new SelectOption('List Views','List Views'));
        return type;
    }
    
    public void loadFields(){
     getfields();
    
    
    }
    
    public void setCurrentfield(String[] currentfield) {
            this.currentfield= currentfield;
        }
        
    public void setCurrentobject(String currentobject) {
            this.currentobject= currentobject;
        }
        
    public void setSelectedType(String type) {
            this.SelectedType= type;
        }
            
    public String generateCode(String currentobj,String[] currentfields){
     String code='';
     map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
        
     code +='<' + 'apex' + ':' + 'page standardController=' + '"' + currentobj + '"' + '>';
     code += '\n';
     code += '<' + 'apex' + ':' + 'sectionHeader' + ' title=' + '"' + describe.get(currentobj).getdescribe().getlabel() + ' Edit' + '"' + ' subtitle=' + '"' + '{' + '!' + currentobj + '.name}' + '"' + '/>';
     code += '\n';
     code += '<' + 'apex' + ':' + 'form' + '>';
     code += '\n';
     code += '<' + 'apex' + ':' + 'pageBlock title=' + '"' + describe.get(currentobj).getdescribe().getlabel() + ' Edit' + '"'  + ' mode=' + '"edit">';
     code += '\n';
     code += '\n';
     code += '<' + 'apex' + ':' + 'pageBlockButtons location=' + '"top">';
     code += '\n';
     code += '<' + 'apex:commandButton value=' + '"' + 'Save' + '" ' + 'action=' + '"' + '{' + '!' + 'save' + '}"' + '/>';
     code += '\n';
     code += '<' + 'apex:commandButton value=' + '"' + 'Save & New' + '"' + ' action=' + '"' + '{' + '!save}" />';
     code += '\n';
     code += '<' + 'apex:commandButton value="Cancel" action=' + '"' + '{' + '!cancel}' + '"/>';
     code += '\n';
     code += '<' + '/apex:pageBlockButtons>';
     code += '\n';
     code += '\n';
     code += '<' + 'apex' + ':' + 'pageBlockButtons location=' + '"bottom">';
     code += '\n';
     code += '<' + 'apex:commandButton value=' + '"' + 'Save' + '" ' + 'action=' + '"' + '{' + '!' + 'save' + '}"' + '/>';
     code += '\n';
     code += '<' + 'apex:commandButton value=' + '"' + 'Save & New' + '"' + ' action=' + '"' + '{' + '!save}" />';
     code += '\n';
     code += '<' + 'apex:commandButton value="Cancel" action=' + '"' + '{' + '!cancel}' + '"/>';
     code += '\n';
     code += '<' + '/apex:pageBlockButtons>';
     code += '\n';
     code += '\n';
     code += '<' + 'apex' + ':' + 'pageblockSection title=' + '"' + describe.get(currentobj).getdescribe().getlabel() + ' Details' + '"'+ '>';
     code += '\n';
     for(String field : currentfields){
     code += '<' + 'apex:inputField value=' + '"' + '{' + '!' + currentobj + '.' + field + '}' + '"' + '/>'; 
     code += '\n';
     
     }
    
    code += '\n';
    code += '<' + '/apex:pageBlockSection>';
    code += '\n';
    code += '<' + '/apex:pageBlock>';
    code += '\n';
    code += '<' + '/apex:form>';
    code += '\n';
    code  += '<' + '/apex:page>';
   
    return code;
    
    }         
   public String generateCode1(String currentobj,String[] currentfields){
     String code='';
     map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
     code +='<' + 'apex' + ':' + 'page standardController=' + '"' + currentobj + '"' + '>';
     code += '\n';
     code += '<' + 'apex' + ':' + 'sectionHeader' + ' title=' + '"' + describe.get(currentobj).getdescribe().getlabel() + ' Edit' + '"' + ' subtitle=' + '"' + '{' + '!' + currentobj + '.name}' + '"' + '/>';
     code += '\n';
     code += '<' + 'apex' + ':' + 'form' + '>';
     code += '\n';
     code += '<' + 'apex' + ':' + 'pageBlock title=' + '"' + describe.get(currentobj).getdescribe().getlabel() + ' Detail' + '"' + ' mode=' + '"edit">';
     code += '\n';
     code += '\n';
     code += '<' + 'apex' + ':' + 'pageBlockButtons location=' + '"top">';
     code += '\n';
     code += '<' + 'apex:commandButton value=' + '"' + 'Save' + '" ' + 'action=' + '"' + '{' + '!' + 'save' + '}"' + '/>';
     code += '\n';
     code += '<' + 'apex:commandButton value=' + '"' + 'Save & New' + '"' + ' action=' + '"' + '{' + '!save}" />';
     code += '\n';
     code += '<' + 'apex:commandButton value="Cancel" action=' + '"' + '{' + '!cancel}' + '"/>';
     code += '\n';
     code += '<' + '/apex:pageBlockButtons>';
     code += '\n';
     code += '\n';
     code += '<' + 'apex' + ':' + 'pageBlockButtons location=' + '"bottom">';
     code += '\n';
     code += '<' + 'apex:commandButton value=' + '"' + 'Save' + '" ' + 'action=' + '"' + '{' + '!' + 'save' + '}"' + '/>';
     code += '\n';
     code += '<' + 'apex:commandButton value=' + '"' + 'Save & New' + '"' + ' action=' + '"' + '{' + '!save}" />';
     code += '\n';
     code += '<' + 'apex:commandButton value="Cancel" action=' + '"' + '{' + '!cancel}' + '"/>';
     code += '\n';
     code += '<' + '/apex:pageBlockButtons>';
     code += '\n';
     code += '\n';
     code += '<' + 'apex' + ':' + 'pageblockSection title=' + '"' + describe.get(currentobj).getdescribe().getlabel() + ' Details' + '"'+ '>';
     code += '\n';
     for(String field : currentfields){
     code += '<' + 'apex:outputField value=' + '"' + '{' + '!' + currentobj + '.' + field + '}' + '"' + '/>'; 
     code += '\n';
     
     }
    
    code += '\n';
    code += '<' + '/apex:pageBlockSection>';
    code += '<' + '/apex:pageBlock>';
    code += '\n';
    code += '<' + '/apex:form>';
    code += '\n';
    code  += '<' + '/apex:page>';
   
    return code;
    
    }         
   public String getCode() {
      //  system.debug('====================codeget========================'+code);
        return code;
        
    }
     public void setCode(String s) {
     //   system.debug('====================codeset========================'+code);
        code=s;
        
    }
    public String getOutput() {
        return output;
    }
   public PageReference generateCodeFinal() {
    // system.debug('====================inside method========================'+code);
   //   system.debug('===================currentobject==============='+SelectedType);
      if(SelectedType=='Custom Detail Page'){
  //    system.debug('========inside detail===========');
      code=generateCode1(currentobject,currentfield);
      
      }else if(SelectedType=='Custom Edit Page'){
    //  system.debug('========inside Edit Custom===========');
       code=generateCode(currentobject,currentfield);
      }
        return null;
    }


}