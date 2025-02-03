List<sf_devops__Submit_Component__c> components = [SELECT Id, sf_devops__File_Path__c, sf_devops__Source_Component__c
FROM sf_devops__Submit_Component__c
WHERE sf_devops__Operation__c = 'REMOVE'
AND sf_devops__Change_Submission__r.sf_devops__Work_Item__r.Name = 'WI-000001'
AND sf_devops__Source_Component__c IN ('CustomMetadataName_1', 'CustomMetadataName_2')];
delete components;