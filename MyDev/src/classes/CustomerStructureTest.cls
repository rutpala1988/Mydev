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

@isTest

private class CustomerStructureTest {
    

    public static testMethod void test() {
        try{
        
        Integer childCount = 4;
        Integer parentCount = 1;
        
        //Create Test Top Parent Account
        Account testParentAccount = new Account(Name='Test Parent Account');
        Insert testParentAccount;
        
        testParentAccount = [Select id, name From Account Where id=: testParentAccount.id];
        
        Opportunity testParentOppty1 = new Opportunity(Name='Test Parent Oppty1', StageName='Closed Won', CloseDate = System.today().addDays(1), AccountId = testParentAccount.id, Amount=10000);
        Insert testParentOppty1;
        Opportunity testParentOppty2 = new Opportunity(Name='Test Parent Oppty2', StageName='Value Proposition', CloseDate=System.today().addDays(1), AccountId = testParentAccount.id, Amount=10000);
        Insert testParentOppty2;
        Opportunity testParentOppty3 = new Opportunity(Name='Test Parent Oppty3', StageName='Value Proposition', CloseDate=System.today().addDays(1), AccountId = testParentAccount.id);
        Insert testParentOppty3;
        
        Contact testContact1 = new Contact(FirstName='Wayne', LastName='Rooney', AccountId = testParentAccount.id);
        Insert testContact1;
       
        Contact testContact2 = new Contact(FirstName='Sir Alex', LastName='Ferguson', AccountId = testParentAccount.id);
        Insert testContact2;
        
        //Create Children Accounts
        Account testChildAccount1 = new Account(Name='Test Child Account 1', ParentId=testParentAccount.id);
        Insert testChildAccount1;
        
        testChildAccount1 = [Select id From Account Where Id =: testChildAccount1.id];
        Opportunity testChildOppty1 = new Opportunity(Name='Test Child Oppty1', StageName='Closed Won', CloseDate=System.today().addDays(1), AccountId = testChildAccount1.id, Amount=10000);
        Insert testChildOppty1;
        Opportunity testChildOppty2 = new Opportunity(Name='Test Child Oppty2', StageName='Value Proposition', CloseDate=System.today().addDays(1), AccountId = testChildAccount1.id, Amount=10000);
        Insert testChildOppty2;
        Contact testChildContact1 = new Contact(FirstName='Ryan', LastName='Giggs', AccountId = testChildAccount1.id);
        Insert testChildContact1;
       
        Contact testChildContact2 = new Contact(FirstName='Eric', LastName='Cantona', AccountId = testChildAccount1.id);
        Insert testChildContact2;
        
            
        Account testChildAccount2 = new Account(Name='Test Child Account 2', ParentId=testParentAccount.id);    
        Insert testChildAccount2; 
        
        testChildAccount2 = [Select id From Account Where Id =: testChildAccount2.id];
        Opportunity testChildOppty11 = new Opportunity(Name='Test Child Oppty11', StageName='Closed Won', CloseDate=System.today().addDays(1), AccountId = testChildAccount2.id, Amount=10000);
        Insert testChildOppty11;
        Opportunity testChildOppty22 = new Opportunity(Name='Test Child Oppty22', StageName='Value Proposition', CloseDate=System.today().addDays(1), AccountId = testChildAccount2.id, Amount=10000);
        Insert testChildOppty22;
        Contact testChildContact11 = new Contact(FirstName='Nemanja', LastName='Vidic', AccountId = testChildAccount2.id);
        Insert testChildContact11;
        
        Contact testChildContact22 = new Contact(FirstName='Gary', LastName='Neville', AccountId = testChildAccount2.id);
        Insert testChildContact22;
        
        
        Account testChildAccount3 = new Account(Name='Test Child Account 3', ParentId=testParentAccount.id);    
        Insert testChildAccount3;
        
        testChildAccount3 = [Select id From Account Where Id =: testChildAccount3.id];
        Opportunity testChildOppty111 = new Opportunity(Name='Test Child Oppty111', StageName='Closed Won', CloseDate=System.today().addDays(1), AccountId = testChildAccount3.id, Amount=10000);
        Insert testChildOppty111;
        Opportunity testChildOppty222 = new Opportunity(Name='Test Child Oppty222', StageName='Value Proposition', CloseDate=System.today().addDays(1), AccountId = testChildAccount3.id, Amount=10000);
        Insert testChildOppty222;
        Contact testChildContact111 = new Contact(FirstName='Paul', LastName='Parker', AccountId = testChildAccount3.id);
        Insert testChildContact111;
        Contact testChildContact222 = new Contact(FirstName='Wesley', LastName='Brown', AccountId = testChildAccount3.id);
        Insert testChildContact222;
        
        Account testChildChildAccount33 = new Account(Name='Test Child Child Account 33', ParentId=testChildAccount3.id);
        Insert testChildChildAccount33;
        
        testChildChildAccount33 = [Select id From Account Where Id =: testChildChildAccount33.id];
        Opportunity testChildChildOppty331 = new Opportunity(Name='Test Child Child Oppty331', StageName='Closed Won', CloseDate=System.today().addDays(1), AccountId = testChildChildAccount33.id, Amount=10000);
        Insert testChildChildOppty331;
        Opportunity testChildChildOppty332 = new Opportunity(Name='Test Child child Oppty332', StageName='Value Proposition', CloseDate=System.today().addDays(1), AccountId = testChildChildAccount33.id, Amount=10000);
        Insert testChildChildOppty332;
        //Contact testChildChildContact331 = new Contact(FirstName='Paul', LastName='Pogba', AccountId = testChildChildAccount33.id);
        //Insert testChildChildContact331;
        //Contact testChildChildContact332 = new Contact(FirstName='Ravel', LastName='Morrison', AccountId = testChildChildAccount33.id);
        //Insert testChildChildContact332; 
        
        ApexPages.StandardController sc = new ApexPages.StandardController(testChildChildAccount33);
        CustomerStructure ext = new CustomerStructure(sc);
        
        
        //System.assertEquals(childCount, ext.index);
        System.assertEquals(ext.masterAccountId, testParentAccount.id);
        System.assertEquals(parentCount, integer.valueOf(ext.masterAccountId));
        }
        
        catch(Exception e)
        {
            system.debug('Error'+ e);
        }
    }
}