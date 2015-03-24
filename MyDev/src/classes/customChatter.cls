public class customChatter {

    public String cPost { get; set; }
    public String cComment{set;get;}
    
    public PageReference share(){
    
    FeedItem fi = new FeedItem();
    fi.body=cPost;
    fi.ParentId  = UserInfo.getUserId();
    
    insert fi;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = cComment;
    fc.FeedItemId = fi.id;
    fc.CreatedById = '005900000012kGM';
    insert fc;
    
    EntitySubscription follow = new EntitySubscription (
                                 parentId = '00690000006EaPL',
                                 subscriberid = UserInfo.getUserId()); //your User Id
    insert follow;
    
    return new pageReference('/'+fi.id).setRedirect(True);
    }
}