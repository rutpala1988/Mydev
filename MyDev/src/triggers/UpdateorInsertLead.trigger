//This Trigger is used to check duplicate values in the list of leads to be inserted /updated
//Also this check whether the Lead which is inserted/updated has unique Email 
//which is different from leads present in the system.

trigger UpdateorInsertLead on Lead bulk(before Insert, before Update)
{
 
 Map<String,Lead> leadMap=new Map<String,Lead>();
 Map<String,Lead> newLeadMap=new Map<String,Lead>();

 
 for(Lead l:Trigger.new)
 {
   //we are checking whether we are inserting a new lead or updating existing Lead's Email Address
   
   if(l.Email!=null)
   {
   if(Trigger.isInsert||(Trigger.isUpdate&&l.Email!=Trigger.oldMap.get(l.id).Email))
   {
   
     //we are checking whether the leadMap is having any duplicate Email adresses.
     if(leadMap.size()==0 || l.Email!=leadMap.get(l.Email).Email)
     {
       leadMap.put(l.Email,l);
       System.debug('+++++++++Lead Id+++++++'+l.id);
       
     }
     else
     {
       l.addError('The Email address is already taken by another new Lead');
     }
   
   }
   
   }
   
   
   for(Lead lead:[select Email from Lead where Email in :leadMap.KeySet()])
   {
     Lead newLead=leadMap.get(lead.Email);
     
     newLead.Email.addError('This Email Id is already associated with another existing Lead');
     
   
   
   }
  
 
 }
 
 
 


}