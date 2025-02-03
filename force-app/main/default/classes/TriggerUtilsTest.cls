/**
 * @description       :
 * @author            : unknown
 * @group             :
 * @last modified on  : 2022-07-11
 * @last modified by  : unknown
**/
@IsTest
public class TriggerUtilsTest {
    @isTest
    static void changedFields() {
        Account newValue = new Account(Name = 'Test');
        Account oldValue = new Account(Name = 'Old Test');
        Test.startTest();
        Set<String> changedFields = TriggerUtils.changedFields(Account.getSObjectType(), newValue, oldValue);
        Test.stopTest();
        System.assert(changedFields.contains('name'));
    }
}
