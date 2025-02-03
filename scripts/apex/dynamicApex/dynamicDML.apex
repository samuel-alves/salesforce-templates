/**
 * Dynamic DML
 * https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dynamic_dml.htm
 */

SObject c =
   Database.query('SELECT Id, FirstName, AccountId, Account.Name FROM Contact LIMIT 1');
SObject a = c.getSObject('Account');


// Insert child and associate with parent using an external key
insert new Contact(
    FirstName = 'Dynamic',
    LastName = 'DML',
    Account = new Account(VAT__c = 'PT502043059'));