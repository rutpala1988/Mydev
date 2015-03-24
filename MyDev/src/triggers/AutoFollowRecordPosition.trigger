trigger AutoFollowRecordPosition on Position__c(after insert,after update){
for(Position__c obj:Trigger.New)
{
EntitySubScription sub =new EntitySubScription();
sub.ParentId=obj.Id;
sub.SubScriberId=UserInfo.getuserId();
insert sub;
}
}