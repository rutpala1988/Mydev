global class NextCase {
    global static boolean showEmpty {get;set;}
    
    public Case myCase {get;set;}
    public NextCase() {
        doConstructor();
    }

    public NextCase(ApexPages.StandardController std) {
        doConstructor();
    }
    /*public NextCase(ApexPages.StandardSetController std) { 
        doConstructor();
    }*/

    
    public void doConstructor() {
        String userId = UserInfo.getUserId();
        
        List<Group> gList = [Select id from Group where type='Queue'];
        Set<String> mySet = new Set<String>();
        for (Group g:glist) {
            mySet.add(g.id);
        }
        
        qList = new Set<String>();
        qList2 = new Set<String>();
        List<GroupMember> memberList = [select g.UserOrGroupId, g.GroupId From GroupMember g where groupId IN :mySet];
        for (GroupMember gm:memberList) {
            if (userId == gm.UserOrGroupId) {
                qList.add(gm.GroupId);
                qList2.add(gm.GroupId);
            }
        }
    }
    
    
    public list<case> myCases {Get;set;}
    public String nextId {Get;set;}
    public Set<String> qList {Get;set;}
    global static Set<String> qList2 {Get;set;}
    public void getCase() {
        myCases = [Select id,CaseNumber,CasesAvailable__c,createddate,status,OwnerId from Case where status='new' AND OwnerId IN :qList order by createddate desc];
        
        if (myCases.size() > 0) {
            myCase = myCases[0];
            if (myCases.size() > 1) nextId = myCases[1].id;
            if (myCase.id != null) {
                myCase.Status = 'Work In Progress';
                myCase.ownerId = userInfo.getUserId();
                update myCase;
            }
        }else showEmpty = true;
    }
    
    public Map<String,integer> queueList {Get;set;}
    public void getMap() {
        String userId = UserInfo.getUserId();
        List<Group> gList = [Select id from Group where type='Queue'];
        Set<String> mySet = new Set<String>();
        for (Group g:glist) {
            mySet.add(g.id);
        }
        
        Set<String> qList = new Set<String>();
        List<GroupMember> memberList = [select g.UserOrGroupId, g.GroupId From GroupMember g where groupId IN :mySet];
        for (GroupMember gm:memberList) {
            if (userId == gm.UserOrGroupId) {
                qList.add(gm.GroupId);
            }
        }
        
        queueList = new Map<String,integer>();
        
        List<Group> g2List = [SELECT CreatedById,CreatedDate,DeveloperName,DoesIncludeBosses,DoesSendEmailToMembers,Email,Id,LastModifiedById,LastModifiedDate,Name,OwnerId,RelatedId,SystemModstamp,Type FROM Group where id in :qList];
        for(Group g : g2List) {
            integer count = [select count() from case where ownerid =:g.id and status='new'];
            queueList.put(g.name, count);
        }
    }
    
    
    
    
    @RemoteAction
    global static Case getCaseId() { 
        
        String userId = UserInfo.getUserId();
        
        List<Group> gList = [Select id from Group where type='Queue'];
        Set<String> mySet = new Set<String>();
        for (Group g:glist) {
            mySet.add(g.id);
        }
        
        Set<String> qList = new Set<String>();
        List<GroupMember> memberList = [select g.UserOrGroupId, g.GroupId From GroupMember g where groupId IN :mySet];
        for (GroupMember gm:memberList) {
            if (userId == gm.UserOrGroupId) {
                qList.add(gm.GroupId);
            }
        }
        
        
        List<Case> myCases = [Select id,CasesAvailable__c,CaseNumber,createddate,status,OwnerId from Case where status='new' AND OwnerId IN :qList order by createddate];
        Case myCase;
        system.debug('DEUBG: cases:' + myCases);
        system.debug('queue list:' + qList2);
        if (myCases.size() > 0) {
            myCase = myCases[0];
            //if (myCases.size() > 1) nextId = myCases[1].id;
            if (myCase.id != null) {
                myCase.Status = 'Work In Progress';
                myCase.ownerId = userInfo.getUserId();
                myCase.CasesAvailable__c = myCases.size() - 1;
                update myCase;
                return myCase;
            }
        }
        return null;
    }
}