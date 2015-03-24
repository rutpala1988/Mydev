public with sharing class MyStrateicAssist1 {

    public String d1 { get; set; }
    public document d;
    
    public MyStrateicAssist1 ()
    {
     d=[select Id,name from document where id=:ApexPages.currentPage().getParameters().get('did')];
     d1=d.id;
    }
}