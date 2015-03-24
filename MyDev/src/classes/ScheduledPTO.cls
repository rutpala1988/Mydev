global class ScheduledPTO implements Schedulable
{
    private Attachment attach;
    public ScheduledPTO(Attachment a)
    {
        attach = a;
    }
    
    global void execute(SchedulableContext SC) 
    {
        if(attach.body != null)
        {
            ConnectApi.BinaryInput binaryInput = new ConnectApi.BinaryInput(attach.Body, 'image/png', attach.Name);
            //change chatter image using chatter apex ConnectApi.ChatterUsers.setPhoto
            ConnectApi.ChatterUsers.setPhoto(null, UserInfo.getUserId(), binaryInput);//String communityId, String userId, ConnectApi.BinaryInput Class fileUpload
        }
    }
}