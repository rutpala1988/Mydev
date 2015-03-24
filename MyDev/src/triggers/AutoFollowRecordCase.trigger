trigger AutoFollowRecordCase on Case(after insert,after update){
for(Case obj:Trigger.New)
{
EntitySubScription sub =new EntitySubScription();
sub.ParentId=obj.Id;
sub.SubScriberId=UserInfo.getuserId();
insert sub;
}
}