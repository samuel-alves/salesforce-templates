/**
 * @description       :
 * @author            : samuelalves@loba.pt
 * @group             :
 * @last modified on  : 2023-03-01
 * @last modified by  : samuelalves@loba.com
 **/
public class TriggerUtils {
    public static Set<String> changedFields(Schema.SObjectType sObjectType, SObject newValue, SObject oldValue) {
        String sObjectName = sObjectType.getDescribe().getName();
        Map<String, Schema.SObjectField> fields = Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap();
        Set<String> changedFieldsSet = new Set<String>();
        for (String field : fields.keyset()) {
            if (newValue.get(field) != oldValue.get(field)) {
                changedFieldsSet.add(field.toLowerCase());
            }
        }
        return changedFieldsSet;
    }
}
