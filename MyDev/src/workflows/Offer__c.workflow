<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>New Position Requires Attention</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Offer__c.Status__c</field>
            <operation>equals</operation>
            <value>Sent</value>
        </criteriaItems>
        <description>If an offer is in sent status for more than 2 days send notification to recruiter</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>New_Position_Requires_attention</name>
                <type>Task</type>
            </actions>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>New_Position_Requires_attention</fullName>
        <assignedTo>raghunath.utpala@gmail.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>New Position requires attention and needs to looked.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>New Position Requires attention</subject>
    </tasks>
</Workflow>
