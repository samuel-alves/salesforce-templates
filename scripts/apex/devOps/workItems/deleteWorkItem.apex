/**
 * @description       :
 * @author            : unknown
 * @group             :
 * @last modified on  : 2025-02-03
 * @last modified by  : unknown
**/
Id projectId = '000000000000000000';
// String projectName = '%DummyProject%';
// sf_devops__Project__c proj = [SELECT Id, Name, sf_devops__Platform_Repository__c FROM sf_devops__Project__c WHERE Name LIKE :projectName LIMIT 100];

// Set<String> workItemNumbers = new Set<String>{'WI-001549', 'WI-001548', 'WI-001539'};

// List<sf_devops__Work_Item__c> workItems = [SELECT Id FROM sf_devops__Work_Item__c WHERE Name IN :workItemNumbers LIMIT 100];
List<sf_devops__Work_Item__c> workItems = [SELECT Id, Name FROM sf_devops__Work_Item__c WHERE sf_devops__Project__c = :projectId AND Name IN ('WI-000001', 'WI-000002') LIMIT 100];
// Assert.areEqual(1, workItems.size());

Set<Id> wiIds = new Set<Id>();
Set<String> wiName = new Set<String>();
for(sf_devops__Work_Item__c wi : workItems) {
    wiIds.add(wi.Id);
    wiName.add(wi.Name);
}

List<sf_devops__Change_Submission__c> changeSubs = [SELECT Id FROM sf_devops__Change_Submission__c WHERE sf_devops__Work_Item__c IN :wiIds];
Set<Id> csIds = new Set<Id>();
for(sf_devops__Change_Submission__c cs : changeSubs) {
    csIds.add(cs.Id);
}


System.debug('DELETE workItems: ' + workItems);
System.debug('DELETE remote changes');
System.debug('DELETE changeSubs: ' + changeSubs);

delete [SELECT Id FROM sf_devops__Remote_Change__c WHERE sf_devops__Change_Submission__c IN :csIds];
delete [SELECT Id FROM sf_devops__Vcs_Event__c WHERE sf_devops__Source_Branch__c  IN :wiName];

delete changeSubs;
delete workItems;