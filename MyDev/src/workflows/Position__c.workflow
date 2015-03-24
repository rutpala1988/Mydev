<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Assign_New_Position_to_Recruiter_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>raghunath.utpala@gmail.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign New Position to Recruiter Queue</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Route_New_Position_to_Recruiter_Queue</fullName>
        <description>This action is to automatically route the new position to Recruiter Queue</description>
        <field>OwnerId</field>
        <lookupValue>Recruiter_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Route New Position to Recruiter Queue</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>New Position Routed to Recruiter Queue</fullName>
        <actions>
            <name>Route_New_Position_to_Recruiter_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Position__c.Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>The newly created position must be routed to Recruiters Queue</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
