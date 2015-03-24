<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>DR_Approval_Notification</fullName>
        <ccEmails>raghunath.utpala@gmail.com</ccEmails>
        <ccEmails>utpala.raghunath@gmail.com</ccEmails>
        <description>DR Approval Notification</description>
        <protected>true</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/DR_Approved_Notification</template>
    </alerts>
    <alerts>
        <fullName>DR_Approval_Notification1</fullName>
        <ccEmails>raghunath.utpala@gmail.com</ccEmails>
        <ccEmails>utpala.raghunath@gmail.com</ccEmails>
        <description>DR Approval Notification1</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/DR_Approved_Notification</template>
    </alerts>
    <alerts>
        <fullName>DR_Rejection_Notification</fullName>
        <ccEmails>utpala.raghunath@gmail.com</ccEmails>
        <ccEmails>raghunath.utpala@gmail.com</ccEmails>
        <description>DR Rejection Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/DR_Rejected_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>DR_Approved_status</fullName>
        <field>Status</field>
        <literalValue>Converted to Opportunity</literalValue>
        <name>DR Approved status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR_Rejected_Status</fullName>
        <field>Status</field>
        <literalValue>Rejected</literalValue>
        <name>DR Rejected Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR_Submitted_Status</fullName>
        <field>Status</field>
        <literalValue>Submitted</literalValue>
        <name>DR Submitted Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
