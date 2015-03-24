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

public class Node {
        
        public String icon;
        public String text;
        public String url;
        public List<Node> children = new List<Node>(); 
        public Boolean leaf;
        public Boolean isRoot;
        public Boolean closed;
        public String cur = UserInfo.getDefaultCurrency(); //Set the currency to the default system currency this can be hardcoded e.g. public String cur = 'EUR';

        //Add Contact Details
        public Node(Contact c) {
            icon = '/img/icon/alohaProfile16.png'; //icon taken from SFDC icons no need to upload icon as it's already in the org
            text = c.Name + ', ' + c.Title + ', ' + c.Phone; //More details can be added here from the Contact object if required
            url = '/' + c.Id;
            leaf = true;
            isRoot = false;
        }
        
        //Add Opportunity details and check if open or closed
        public Node(Opportunity o) {
            if(o.Amount == null){ //Sets the Opportunity Amount to 0.00 otherwise error is returned when querying opportunities with no values
                o.Amount = 0.00;
            }
            icon = '/img/icon/cash16.png'; //icon taken from SFDC icons no need to upload icon as it's already in the org
            text = o.Name + ', ' + o.Amount.format() +' ' + cur + ', ' + o.CloseDate.format(); //More details can be added here from the Opportunity object if required
            url = '/' + o.Id;
            leaf = true;
            isRoot = false;
            if (o.IsClosed)
                closed = true;
            else
                closed = false;
        }
        
        public Node() {}
        
        //Check if Node has Children
        public Boolean hasChildren() {
            if (children.size() > 0)
                return true;
            return false;
        }
        
        //Add a child Node to a parent
        public Node addChildNode(Node node) {
            this.children.add(node);
            return this;
        }

}