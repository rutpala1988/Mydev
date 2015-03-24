<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Reminder_please_complete_Postmortem</fullName>
        <description>Reminder : please complete Postmortem</description>
        <protected>false</protected>
        <recipients>
            <recipient>Sales_Operations</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SupportCaseResponse</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Next_Step_Field</fullName>
        <description>when an opportunity is closed/lost next step field update</description>
        <field>NextStep</field>
        <formula>&quot;Conducting Competitor Review&quot;</formula>
        <name>Update Next Step Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Lost Oppurtunity Due to a competitor</fullName>
        <actions>
            <name>Reminder_please_complete_Postmortem</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Next_Step_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Lost_Due_to_Competitor</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Lost</value>
        </criteriaItems>
        <description>Lost Oppurtunity Due to a competitor</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>Lost_Due_to_Competitor</fullName>
        <assignedTo>raghunath.utpala@gmail.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>Please work on this within seven days.</description>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Lost Due to Competitor</subject>
    </tasks>
</Workflow>
