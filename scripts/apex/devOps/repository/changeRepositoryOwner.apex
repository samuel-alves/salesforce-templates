/**
 * @description       :
 * @author            : unknown
 * @group             :
 * @last modified on  : 2025-02-03
 * @last modified by  : unknown
**/
String repName = '%/DummyProject%';
String oldOwner = 'GIT_OWNER_OLD';
String newOwner = 'GIT_OWNER_NEW';

public void changeRepositoryOwner(String repName, String oldOwner, String newOwner) {
    List<sf_devops__Repository__c> repos = [SELECT Id, sf_devops__GitHub_Owner__c, sf_devops__Path__c, Name FROM sf_devops__Repository__c WHERE Name LIKE :repName];

    Assert.areEqual(1, repos.size(), 'Double check repository name');

    repos[0].sf_devops__GitHub_Owner__c = newOwner;
    repos[0].sf_devops__Path__c = repos[0].sf_devops__Path__c.replaceAll(oldOwner, newOwner);
    repos[0].Name = repos[0].Name.replaceAll(oldOwner, newOwner);
    update repos;
}
changeRepositoryOwner(repName, oldOwner, newOwner);