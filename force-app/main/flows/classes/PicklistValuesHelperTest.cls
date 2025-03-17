@IsTest
public with sharing class PicklistValuesHelperTest {
    @IsTest
    static void testMethodName() {
        String mockBody = '{"picklistFieldValues":{"Option1__c":{"values":[{"value":"Value1","validFor":[],"label":"Value1","attributes":null},{"value":"Value2","validFor":[],"label":"Value2","attributes":null},{"value":"Value3","validFor":[],"label":"Value3","attributes":null}],"url":"/services/data/v63.0/ui-api/object-info/Demo__c/picklist-values/000000000000001/Option1__c","eTag":"0000000000000000000000001","defaultValue":null,"controllerValues":{}},"CurrencyIsoCode":{"values":[{"value":"EUR","validFor":[],"label":"EUR - Euro","attributes":null},{"value":"USD","validFor":[],"label":"USD - U.S. Dollar","attributes":null}],"url":"/services/data/v63.0/ui-api/object-info/Demo__c/picklist-values/000000000000001/CurrencyIsoCode","eTag":"0000000000000000000000002","defaultValue":{"value":"EUR","validFor":[],"label":"EUR - Euro","attributes":null},"controllerValues":{}}},"eTag":"0000000000000000000000003"}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200,'ok',mockBody,new Map<String, String>()));

        Test.startTest();
        List<PicklistValuesHelper.Results> results = PicklistValuesHelper.getPicklistValues(new List<PicklistValuesHelper.Requests>{
            new PicklistValuesHelper.Requests('Demo__c', 'DemoRec2', 'Option1__c')
        });

        System.debug(results[0]);
        Test.stopTest();
    }
}