
/**
 * @description       : 3 ways to work with custom settings in an Apex unit test
 * https://www.joelemmer.com/custom-settings-in-salesforce-apex-unit-tests/
 *
 * @author            : unknown
 * @group             :
 * @last modified on  : 2023-01-02
 * @last modified by  : unknown
**/


/**
 * 1. Inserting List Custom Settings with Apex
 */
StateSetting__c california = new StateSetting();
california.Name = 'CA';
california.State__c = 'California';
insert california;


/**
 * 2. Inserting Hierarchy Custom Settings with Apex
 */
// 2.1. Inserting an org default hierarchy custom setting
Discount__c orgDefaultDisc = new Discount__c(
    SetupOwnerId=UserInfo.getOrganizationId(),
    Discount__c=0.05
);
insert orgDefaultDisc;

// 2.2. Inserting a profile-level hierarchy custom setting
Profile salesPersonProfile = [
    Select Id From Profile
    Where Name = 'Sales Person'
];
Discount__c salesPersonDisc = new Discount__c(
    SetupOwnerId=profile.Id,
    Discount__c=0.1
);
insert salesPersonDisc;

// 2.3. Inserting a user-level hierarchy custom setting
User vpOfSales = new User...    // Create appropriate user
Discount__c vpOfSalesDisc = new Discount__c(
    SetupOwnerId=vpOfSales.Id,
    Discount__c=0.2
);
insert vpOfSalesDisc;

