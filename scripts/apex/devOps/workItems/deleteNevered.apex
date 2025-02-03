Id projectId = '000000000000000000';

List<sf_devops__Work_Item__c> workItems = [SELECT sf_devops__Project__r.Name, sf_devops__State__c FROM sf_devops__Work_Item__c WHERE sf_devops__Project__c = :projectId AND sf_devops__State__c = 'NEW' AND LastModifiedDate != TODAY ORDER BY sf_devops__State__c];
Database.DeleteResult[] result = Database.delete(workItems, false);
for(Database.DeleteResult r : result) {
    if(!r.isSuccess()) {
        System.debug(r);
    }
}


delete [SELECT Id FROM sf_devops__Back_Sync__c WHERE Id IN ('a5BQB000000006T', 'a5BQB0000000085')];