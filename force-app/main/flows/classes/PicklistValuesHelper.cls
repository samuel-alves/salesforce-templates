public class PicklistValuesHelper {

    @InvocableMethod(label='Get Picklist Values')
    public static List<Results> getPicklistValues(List<Requests> requests) {
        List<PicklistOptions> picklistEntries = new List<PicklistOptions>();
        List<Results> results = new List<Results>();

        if (requests.isEmpty()) {
            return results;
        }

        Requests request = requests[0];

        // recordTypeDeveloperName
        Id recordTypeId = Schema.SObjectType.Demo__c.getRecordTypeInfosByDeveloperName().get(request.recordTypeDeveloperName).getRecordTypeId();

        // System.debug(URL.getOrgDomainUrl().toExternalForm() + '/services/data/v63.0/ui-api/object-info/' + request.objectName + '/picklist-values/' + recordTypeId);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(URL.getOrgDomainUrl().toExternalForm() + '/services/data/v63.0/ui-api/object-info/' + request.objectName + '/picklist-values/' + recordTypeId);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() != 200) {
            return null;
        }

        Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        Map<String, Object> picklistMap = (Map<String, Object>) responseBody.get('picklistFieldValues');
        Map<String, Object> picklistField = (Map<String, Object>) picklistMap.get(request.fieldName);
        List<Object> picklistValues = (List<Object>) picklistField.get('values');

        // System.debug('responseBody: ' + JSON.serialize(responseBody));
        // System.debug('responseBody: ' + JSON.serialize(picklistValues));

        List<PicklistOptions> picklistOptions = new List<PicklistOptions>();
        for (Object record : picklistValues) {
            Map<String,Object> recordMap = (Map<String,Object>) record;
            picklistOptions.add(new PicklistOptions((String) recordMap.get('label'), (String) recordMap.get('value')));
        }
        results.add(new Results(picklistOptions));

        // System.debug(JSON.serialize(results));

       return results;
    }

    public class Requests {
        @InvocableVariable(label='Object Name' required=true)
        public String objectName;

        @InvocableVariable(label='Record Type DeveloperName' required=true)
        public String recordTypeDeveloperName;

        @InvocableVariable(label='Field Name' required=true)
        public String fieldName;

        public Requests() {}

        public Requests(String objectName, String recordTypeDeveloperName, String fieldName) {
            this.objectName = objectName;
            this.recordTypeDeveloperName = recordTypeDeveloperName;
            this.fieldName = fieldName;
        }
    }

    public class Results {
        @InvocableVariable(label='Records for Output' description='yourDescription' required=true)
        public List<PicklistOptions> picklistEntries;

        public Results(List<PicklistOptions> picklistEntries) {
            this.picklistEntries = picklistEntries;
        }
    }

    // public class PicklistOptions {
    //     @AuraEnabled public String label;
    //     @AuraEnabled public String value;
    //     public PicklistOptions(String label, String value) {
    //         this.label = label;
    //         this.value = value;
    //     }
    // }
}