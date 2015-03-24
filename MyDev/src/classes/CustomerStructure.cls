// Copyright 2011, Odhrán Lenaghan - Sales Support Engineering, Salesforce.com Inc.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following
// conditions are met:
//
// - Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. 
// - Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
//   disclaimer in the documentation and/or other materials provided with the distribution.
// - Neither the name of the salesforce.com nor the names of its contributors may be used to endorse or promote products derived
//   from this software without specific prior written permission. 
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

public class CustomerStructure {    
    
    //Declare Variables
    private final Account acct;    
    
    public String masterAccountId {get; set;}            //Top Parent Account ID
    public Account masterAccount {get; set;}             //Top Parent Account     
    
    public Node node {get; set;}                         //Top Level Node
                  
    public String nodeJSON {get; set;}                   //JSON String that stores all the Nodes 
    public Integer index {get; set;}                     //Index for NavigateNodes loop
    
    
    public CustomerStructure(ApexPages.StandardController controller) {
        
        acct = (Account) controller.getRecord();         //Get the record ID from the current page
        
        masterAccountId = getUltimateParent(acct.id);    //Find Top Id of the structure and assign it to the masterAccountId variable
        
        node = new Node();                               //Create new node
        node = getAccountNode(masterAccountId);          //Get Account node info for the masterAccountId
        node.icon = '/img/icon/star16.png';              //Add star image as this is the Root Node of the hierarchy tree
        
        navigateNodes();                                 //Find all children of the parent and assign to node
        
        nodeJSON = '['+JSON.serialize(node)+']';         //Serialize the node list and assign to String for the Ext JavaScript Library
       
    }

    //Find the Ultimate Parent of the Hierarchy Structure
    public String getUltimateParent(String currentId){
        
        Boolean ultimate = false;
        
        while (ultimate != true) {
            
            Account a = [Select a.ParentId, a.Name, a.Id From Account a Where a.Id =: currentId LIMIT 1];
            
            if (a.ParentId != null){
                currentId = a.ParentId;                
            }
            else{
                masterAccount = [select id, Name from Account where id =: currentId];
                
                ultimate = true;
            }
        }
        
        return currentId;        
    }
    
    //Navigate Nodes to get the children of the structure
    public void navigateNodes() {
        
        List<Account> accountsToNavigate = new List<Account>{masterAccount};
        List<Node> nodesAtParentLevel = new List<Node>{node};
       
        while(!accountsToNavigate.isEmpty()) {
            
            index = 0;
            
            List<Account> childAccountsThisLevel = new List<Account>();
            List<Node> nodesThisLevel = new List<Node>();
            
            for(Account a: accountsToNavigate) {
               Node parentNode = nodesAtParentLevel[index];
               
               List<Account> accts = childAccounts(a.id);
               
               childAccountsThisLevel.addAll(accts); 
               
               List<Node> childNodes = childNodes(accts, parentNode);
               
               nodesThisLevel.addAll(childNodes);
               
               index++; 
               
            }
            
            nodesAtParentLevel = nodesThisLevel;
            accountsToNavigate = childAccountsThisLevel;
        }
    }
    
    public List<Account> childAccounts(String parentId) {
        return [select id, Name from Account where ParentId =:parentId];
    }
    
    public List<Node> childNodes(List<Account>  childAccounts, Node parentNode) {
        
        List<Node> nodes = new List<Node>();
        for(Account a: childAccounts) {
            Node n = new Node();
            n = getAccountNode(a.Id);
            parentNode.addChildNode(n);
            nodes.add(n);
        }
        return nodes;
    }
    
    //Returns a node with Account, their Contacts and their Opportunities Closed v Open
    public Node getAccountNode(String accountId) {
        
        //Query account to return account info, related contacts and related opportunities
        Account a = [Select a.Name, a.Id, (Select Id, Name, IsClosed, Amount, CloseDate From Opportunities), (Select Id, Name, Title, Phone From Contacts) From Account a where id =: accountId];
        
        Node accountNode = new Node(); //Create an accountNode and add an icon, name, url, leaf and isRoot.
                
        if (accountId == acct.id)
            accountNode.text = '<strong>'+a.Name+'</strong>'; //Highlights the Account of the current page to allow user to see the position of the Account in the Company Hierarchy
        else
            accountNode.text = a.Name;
           
        accountNode.url = '/' + a.Id;
        accountNode.leaf = false;
        accountNode.isRoot = true;
        accountNode.icon = '/s.gif" style="background:url(/img/sprites/master.png); background-position: 0px -2px; width: 16px; height: 16px;"'; //Uses the SFDC master sprites and displays the required icon by setting it's background position        
        
        Node contactNode = new Node(); //Create a Contact Header Node and add the contacts as children using the Node class
        
        contactNode.text = 'Contacts';
        contactNode.leaf = false;
        contactNode.icon = '/s.gif" style="background:url(/img/sprites/master.png); background-position: 0px -82px; width: 16px; height: 16px;"';
        
        for (Contact c : a.Contacts) {
            contactNode.addChildNode(new Node(c));
        }
        if (contactNode.hasChildren())
            accountNode.addChildNode(contactNode); //add to Account Node
        
        Node opportunityClosed = new Node(); //Create an Opportunity Closed Header
        
        opportunityClosed.text = 'Opportunity Closed';
        opportunityClosed.leaf = false;
        opportunityClosed.icon = '/s.gif" style="background:url(/img/sprites/master.png); background-position: 0px -242px; width: 16px; height: 16px;"';
        
        Node opportunityOpen = new Node(); //Create an Opportunity Open Header
        
        opportunityOpen.text = 'Opportunity Open';
        opportunityOpen.leaf = false;
        opportunityOpen.icon = '/s.gif" style="background:url(/img/sprites/master.png); background-position: 0px -242px; width: 16px; height: 16px;"';
        
        //Loop all the Opportunities and divide into Won Closed v Open and add to correct header node
        for (Opportunity o : a.Opportunities) {
            if (o.IsClosed)
                opportunityClosed.addChildNode(new Node(o));
            else
                opportunityOpen.addChildNode(new Node(o));
        }
        
        //Add to Account Node
        if (opportunityClosed.hasChildren())
            accountNode.addChildNode(opportunityClosed);
        if (opportunityOpen.hasChildren())
            accountNode.addChildNode(opportunityOpen);
        
        return accountNode; 
    }
    
    
}