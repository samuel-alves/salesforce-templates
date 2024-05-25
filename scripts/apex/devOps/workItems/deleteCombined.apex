Id projectId = '000000000001Kj3000';

List<sf_devops__Work_Item__c> workItems = [SELECT sf_devops__Project__r.Name, sf_devops__State__c FROM sf_devops__Work_Item__c WHERE sf_devops__Project__c = :projectId AND sf_devops__State__c = 'COMBINED'  ORDER BY sf_devops__State__c];


Set<Id> wiIds = new Set<Id>();
for(sf_devops__Work_Item__c wi : workItems) {
    wiIds.add(wi.Id);
}

List<sf_devops__Change_Submission__c> changeSubs = [SELECT Id FROM sf_devops__Change_Submission__c WHERE sf_devops__Work_Item__c IN :wiIds];
Set<Id> csIds = new Set<Id>();
for(sf_devops__Change_Submission__c cs : changeSubs) {
    csIds.add(cs.Id);
}


delete [SELECT Id FROM sf_devops__Remote_Change__c WHERE sf_devops__Change_Submission__c IN :csIds];
delete changeSubs;
Database.DeleteResult[] result = Database.delete(workItems, false);

for(Database.DeleteResult r : result) {
    if(!r.isSuccess()) {
        System.debug(r);
    }
}
