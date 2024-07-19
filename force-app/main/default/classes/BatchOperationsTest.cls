/**
 * @File Name          : BatchOperationsTest.cls
 * @Description        : 
 * @Author             : samuelalves@loba.pt
 * @Group              : 
 * @Last Modified By   : samuelalves@loba.pt
 * @Last Modified On   : 11/14/2019, 9:25:27 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/14/2019   samuelalves@loba.pt     Initial Version
**/
@IsTest
private without sharing class BatchOperationsTest {
    @IsTest
    private static void updateContact() {
        Account acc = new Account(Name = 'Test');
        insert acc;

        Contact c = new Contact();
        c.AccountId = acc.Id;
        c.LastName = 'Loba';
        c.Email = 'test@loba.pt';
        insert c;

        String query = 'SELECT Id FROM Contact';
        String operation = 'update';
        Map<String, Object> newValues = new Map<String, Object>();
        newValues.put('LastName', 'test2');

        Test.startTest(); 
        Database.executeBatch(new BatchOperations(query, operation, newValues, null));

        String sch = '0 0 * * * ?';
        String jobID = System.schedule('BatchDelete - ' + System.now(), sch, new BatchOperations(query, operation, newValues, null));

        Test.stopTest();

        c = [SELECT Id, LastName FROM Contact WHERE Id = :c.Id];
        System.debug('c: ' + c);
        System.assertEquals('test2', c.LastName);
    }

    @IsTest
    private static void deleteContact() {
        Account acc = new Account(Name = 'Test');
        insert acc;

        Contact c = new Contact();
        c.AccountId = acc.Id;
        c.LastName = 'Loba';
        c.Email = 'test@loba.pt';
        insert c;

        String query = 'SELECT Id FROM Contact';
        String operation = 'delete';
        Map<String, Object> newValues = new Map<String, Object>();

        Test.startTest(); 
        Database.executeBatch(new BatchOperations(query, operation, newValues, null));

        Test.stopTest();

        List<Contact> contacts = [SELECT Id, LastName FROM Contact WHERE Id = :c.Id];
        System.assertEquals(0, contacts.size());
    }
}