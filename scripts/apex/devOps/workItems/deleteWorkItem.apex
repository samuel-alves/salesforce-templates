// String projectName = '%DummyProject%';
// sf_devops__Project__c proj = [SELECT Id, Name, sf_devops__Platform_Repository__c FROM sf_devops__Project__c WHERE Name LIKE :projectName LIMIT 100];

String workItemName = 'WI-001413';

List<sf_devops__Work_Item__c> workItems = [SELECT Id FROM sf_devops__Work_Item__c WHERE Name = :workItemName LIMIT 100];
Assert.areEqual(1, workItems.size());

Set<Id> wiIds = new Set<Id>();
for(sf_devops__Work_Item__c wi : workItems) {
    wiIds.add(wi.Id);
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
delete changeSubs;
delete workItems;