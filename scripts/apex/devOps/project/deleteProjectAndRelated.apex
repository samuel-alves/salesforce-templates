String projectName = '%DummyProject%';

sf_devops__Project__c proj = [SELECT Id, Name, sf_devops__Platform_Repository__c FROM sf_devops__Project__c WHERE Name LIKE :projectName LIMIT 100];
sf_devops__Repository__c rep = [SELECT Id FROM sf_devops__Repository__c WHERE Id = :proj.sf_devops__Platform_Repository__c LIMIT 100];
List<sf_devops__Environment__c> env = [SELECT Id FROM sf_devops__Environment__c WHERE sf_devops__Project__c = :proj.Id LIMIT 100];
List<sf_devops__Branch__c> branches = [SELECT Id FROM sf_devops__Branch__c WHERE sf_devops__Repository__c = :rep.Id LIMIT 100];
sf_devops__Pipeline__c pip = [SELECT Id FROM sf_devops__Pipeline__c WHERE sf_devops__Project__c = :proj.Id LIMIT 100];
List<sf_devops__Pipeline_Stage__c> pipStage = [SELECT Id FROM sf_devops__Pipeline_Stage__c WHERE sf_devops__Pipeline__c = :pip.Id LIMIT 100];
List<sf_devops__Work_Item__c> workItems = [SELECT Id FROM sf_devops__Work_Item__c WHERE sf_devops__Project__c = :proj.Id LIMIT 100];

System.debug('proj: ' + proj);
System.debug('rep: ' + rep);
System.debug('env: ' + env);
System.debug('branches: ' + branches);
System.debug('pip: ' + pip);
System.debug('pipStage: ' + pipStage);
System.debug('workItems: ' + workItems);

System.debug('delete workItems');
delete workItems;

System.debug('delete pipStage');
delete pipStage;

System.debug('delete pip');
delete pip;

System.debug('delete branches');
delete branches;

System.debug('delete env');
delete env;

System.debug('proj Id = ' + proj.Id);
System.debug('delete proj');
delete proj;

System.debug('delete rep');
delete rep;
