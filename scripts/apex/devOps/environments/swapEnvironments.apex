/**
 * To swap environments after sandbox refresh for example
 *
 * You're logged in to: https://clientorg--dev.sandbox.my.salesforce.com (Org Id: 000000000000000XX1)
 * Expected environment: https://clientorg--dev.sandbox.my.salesforce.com (Org Id: 000000000000000XX2)
 * Login | Salesforce
 * Salesforce Customer Secure Login Page. Login to your Salesforce Customer Account.
 *
 * swapEnvironments('000000000000000XX1', '000000000000000XX2');
 */

public sf_devops__Environment__c swapEnvironments(Id oldEnvId, Id newEnvId) {
    System.debug('swapEnvironments: ' + oldEnvId + ' -> ' + newEnvId);
    sf_devops__Environment__c env = [SELECT Id, sf_devops__Org_Id__c FROM sf_devops__Environment__c WHERE sf_devops__Org_Id__c = :oldEnvId LIMIT 1];
    env.sf_devops__Org_Id__c = newEnvId;
    update env;
    return sf_devops__Environment__c;
}

