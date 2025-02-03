/**
 * Understanding Apex Describe Information
 * https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dynamic_describe_objects_understanding.htm
 *
 */
SObject accountObj = new Account();

Assert.areEqual(accountObj.getSObjectType(), Account.sObjectType);
Assert.areEqual(accountObj.getSObjectType(), Account.getSObjectType());
Assert.areEqual(Account.sObjectType, Account.getSObjectType());

// Schema.SObjectType.Account == Account.sObjectType.getDescribe()
Schema.DescribeSObjectResult accountDescribeResult = Account.sObjectType.getDescribe();
Assert.areEqual(Schema.SObjectType.Account, Account.sObjectType.getDescribe());

// Schema.SObjectType.Account.fields.Name.getSobjectField() == Account.Name
// Schema.SObjectType.Account.fields.Name == Account.Name.getDescribe()
Schema.DescribeFieldResult accountNameField = Schema.SObjectType.Account.fields.Name;
Assert.areEqual(accountNameField.getSobjectField(), Account.Name);
Assert.areEqual(accountNameField, Account.Name.getDescribe());

accountNameField = accountNameField.getSobjectField().getDescribe();


/**
 * Accessing All sObjects
 */
Map<String, Schema.SObjectType> orgObjects = Schema.getGlobalDescribe();
Assert.areEqual(orgObjects.get('Account'), Account.sObjectType);


/**
 * Accessing All Field Describe Results for an sObject
 */
Map<String, Schema.SObjectField> fields = Schema.SObjectType.Account.fields.getMap();
Map<String, Schema.SObjectField> fields2 = Account.sObjectType.getDescribe().fields.getMap();
Assert.areEqual(fields, fields2);