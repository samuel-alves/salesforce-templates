public class PicklistOptions {
    @AuraEnabled public String label;
    @AuraEnabled public String value;
    public PicklistOptions(String label, String value) {
        this.label = label;
        this.value = value;
    }
}