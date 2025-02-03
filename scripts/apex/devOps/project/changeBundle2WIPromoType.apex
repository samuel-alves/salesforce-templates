/**
 * @description       : Disable versioned stage
 *
 * https://developer.salesforce.com/docs/atlas.en-us.devops_center_dev.meta/devops_center_dev/sforce_api_objects_sf_devops__pipeline_stage__c.htm
 *
 * Usefull tips:
 * Check Validation Rule "No_Changes_For_Active_Pipelines" on Pipeline Stage
 *
 * @author            : unknown
 * @group             :
 * @last modified on  : 2025-02-03
 * @last modified by  : unknown
**/

Id projectId = 'SF_PROJECT_ID';

sf_devops__Pipeline_Stage__c stage = [
    SELECT Id, Name, sf_devops__Versioned__c
    FROM sf_devops__Pipeline_Stage__c
    WHERE sf_devops__Environment__r.sf_devops__Project__c = :projectId
    AND Name = 'Production'
];

// If true, this pipeline stage accepts only change bundles for promotion. If false, this pipeline stage accepts only work items for promotion.
stage.sf_devops__Versioned__c = false;
update stage;