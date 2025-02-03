/**
 * Describing Tabs Using Schema Methods
 * https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dynamic_describeTabs.htm
 */

// Describe AppTabs (tabs for each app)
List<Schema.DescribeTabSetResult> appsTabs = Schema.describeTabs();

for (Schema.DescribeTabSetResult appTabs : appsTabs) {
    String appLabel = appTabs.getLabel();
    if (appLabel == 'Sales') {
        List<Schema.DescribeTabResult> salesTabs =appTabs.getTabs();
        for (Schema.DescribeTabResult tab : salesTabs) {
            System.debug('Name: ' + tab.getName());
        }
    }
}