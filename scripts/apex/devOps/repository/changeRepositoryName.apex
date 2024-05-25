String repName = '%/DummyProject%';
String oldName = 'GIT_USER/DummyProject';
String newName = 'GIT_USER/DummyProject2';

public void changeRepositoryName(String repName, String oldName, String newName) {
    List<sf_devops__Repository__c> repos = [
        SELECT Id, sf_devops__GitHub_Owner__c, sf_devops__GitHub_Repo__c, Name
        FROM sf_devops__Repository__c
        WHERE Name LIKE :repName
    ];

    Assert.areEqual(1, repos.size(), 'Double check repository name');

    System.debug(JSON.serialize(repos[0]));

    repos[0].Name = repos[0].Name.replaceAll(oldName, newName);
    repos[0].sf_devops__GitHub_Repo__c = repos[0].sf_devops__GitHub_Repo__c.replaceAll(oldName, newName);
    update repos;

    System.debug(JSON.serialize(repos[0]));

    List<sf_devops__Vcs_Event__c> events = [SELECT Id, sf_devops__Payload__c FROM sf_devops__Vcs_Event__c WHERE sf_devops__Repository__c = :repos[0].Id];
    events[0].sf_devops__Payload__c = events[0].sf_devops__Payload__c.replaceAll(oldName, oldName);
    update events;
}
