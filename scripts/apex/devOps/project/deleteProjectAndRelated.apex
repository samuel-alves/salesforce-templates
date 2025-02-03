/**
 * @description       :
 * @author            : unknown
 * @group             :
 * @last modified on  : 2025-02-03
 * @last modified by  : unknown
**/
// String projectName = '%DevOps Demo%';
// sf_devops__Project__c proj = [SELECT Id, Name, sf_devops__Platform_Repository__c FROM sf_devops__Project__c WHERE Id = :projectId  LIMIT 1];

String projectId = '000000000000000000';
String projectName = '%teste%';  // used for double check
sf_devops__Project__c proj = [SELECT Id, Name, sf_devops__Platform_Repository__c FROM sf_devops__Project__c WHERE Id = :projectId  AND Name LIKE :projectName LIMIT 1];

sf_devops__Repository__c rep = [SELECT Id FROM sf_devops__Repository__c WHERE Id = :proj.sf_devops__Platform_Repository__c];

List<sf_devops__Environment__c> envs = [SELECT Id FROM sf_devops__Environment__c WHERE sf_devops__Project__c = :proj.Id];
Set<Id> envIds = new Set<Id>();
for (sf_devops__Environment__c env : envs) {
    envIds.add(env.Id);
}
List<sf_devops__Change_Bundle_Install__c> bundleInstalls = [SELECT Id FROM sf_devops__Change_Bundle_Install__c WHERE sf_devops__Environment__c IN :envIds];

List<sf_devops__Back_Sync__c> backSyncs = [SELECT Id FROM sf_devops__Back_Sync__c WHERE sf_devops__Destination_Environment__c IN :envIds];
List<sf_devops__Branch__c> branches = [SELECT Id FROM sf_devops__Branch__c WHERE sf_devops__Repository__c = :rep.Id];
sf_devops__Pipeline__c pip = [SELECT Id FROM sf_devops__Pipeline__c WHERE sf_devops__Project__c = :proj.Id];
List<sf_devops__Pipeline_Stage__c> pipStage = [SELECT Id FROM sf_devops__Pipeline_Stage__c WHERE sf_devops__Pipeline__c = :pip.Id];

List<sf_devops__Work_Item__c> workItems = [SELECT Id, Name FROM sf_devops__Work_Item__c WHERE sf_devops__Project__c = :proj.Id];
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

List<sf_devops__Vcs_Synch_State__c> vcsSyncs = [SELECT Id FROM sf_devops__Vcs_Synch_State__c WHERE sf_devops__Project__c = :proj.Id];

System.debug('proj: ' + proj);
System.debug('rep: ' + rep);
System.debug('envs: ' + envs);
System.debug('bundleInstalls: ' + bundleInstalls);
System.debug('branches: ' + branches);
System.debug('pip: ' + pip);
System.debug('pipStage: ' + pipStage);
System.debug('workItems: ' + workItems);
System.debug('changeSubs: ' + changeSubs);
System.debug('vcsSyncs: ' + vcsSyncs);

System.debug('delete remote changes');
delete [SELECT Id FROM sf_devops__Remote_Change__c WHERE sf_devops__Change_Submission__c IN :csIds];

System.debug('delete vcsSyncs');
delete vcsSyncs;

System.debug('delete changeSubs');
delete changeSubs;

System.debug('delete workItems');
delete workItems;

System.debug('delete backSyncs');
delete backSyncs;

System.debug('delete pipStage');
delete pipStage;

System.debug('delete pip');
delete pip;

System.debug('delete branches');
delete branches;

System.debug('delete bundleInstalls');
delete bundleInstalls;

System.debug('delete envs');
delete envs;

System.debug('proj Id = ' + proj.Id);
System.debug('delete proj');
delete proj;

delete [SELECT Id FROM sf_devops__Vcs_Event__c WHERE sf_devops__Source_Branch__c  IN :wiName];

System.debug('delete rep');
delete rep;



// TODO: clean sf_devops__Async_Operation_Result__c
// select Id, (select id, name from sf_devops__Work_Items__r) from sf_devops__Async_Operation_Result__c