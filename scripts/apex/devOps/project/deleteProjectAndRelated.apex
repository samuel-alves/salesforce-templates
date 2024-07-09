// String projectName = '%DevOps Demo%';
// sf_devops__Project__c proj = [SELECT Id, Name, sf_devops__Platform_Repository__c FROM sf_devops__Project__c WHERE Id = :projectId  LIMIT 1];

String projectId = 'PROJECT_ID';
sf_devops__Project__c proj = [SELECT Id, Name, sf_devops__Platform_Repository__c FROM sf_devops__Project__c WHERE Id = :projectId  LIMIT 1];

sf_devops__Repository__c rep = [SELECT Id FROM sf_devops__Repository__c WHERE Id = :proj.sf_devops__Platform_Repository__c LIMIT 100];
List<sf_devops__Environment__c> envs = [SELECT Id FROM sf_devops__Environment__c WHERE sf_devops__Project__c = :proj.Id LIMIT 100];
Set<Id> envIds = new Set<Id>();
for (sf_devops__Environment__c env : envs) {
    envIds.add(env.Id);
}
List<sf_devops__Back_Sync__c> backSyncs = [SELECT Id FROM sf_devops__Back_Sync__c WHERE sf_devops__Destination_Environment__c IN :envIds LIMIT 100];
List<sf_devops__Branch__c> branches = [SELECT Id FROM sf_devops__Branch__c WHERE sf_devops__Repository__c = :rep.Id LIMIT 100];
sf_devops__Pipeline__c pip = [SELECT Id FROM sf_devops__Pipeline__c WHERE sf_devops__Project__c = :proj.Id LIMIT 100];
List<sf_devops__Pipeline_Stage__c> pipStage = [SELECT Id FROM sf_devops__Pipeline_Stage__c WHERE sf_devops__Pipeline__c = :pip.Id LIMIT 100];

List<sf_devops__Work_Item__c> workItems = [SELECT Id FROM sf_devops__Work_Item__c WHERE sf_devops__Project__c = :proj.Id LIMIT 100];
Set<Id> wiIds = new Set<Id>();
for(sf_devops__Work_Item__c wi : workItems) {
    wiIds.add(wi.Id);
}

List<sf_devops__Change_Submission__c> changeSubs = [SELECT Id FROM sf_devops__Change_Submission__c WHERE sf_devops__Work_Item__c IN :wiIds];
Set<Id> csIds = new Set<Id>();
for(sf_devops__Change_Submission__c cs : changeSubs) {
    csIds.add(cs.Id);
}

System.debug('proj: ' + proj);
System.debug('rep: ' + rep);
System.debug('envs: ' + envs);
System.debug('branches: ' + branches);
System.debug('pip: ' + pip);
System.debug('pipStage: ' + pipStage);
System.debug('changeSubs: ' + changeSubs);
System.debug('workItems: ' + workItems);

System.debug('delete remote changes');
delete [SELECT Id FROM sf_devops__Remote_Change__c WHERE sf_devops__Change_Submission__c IN :csIds];

System.debug('delete changeSubs');
Database.delete(changeSubs, false);

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

System.debug('delete envs');
delete envs;

System.debug('proj Id = ' + proj.Id);
System.debug('delete proj');
delete proj;

System.debug('delete rep');
delete rep;
