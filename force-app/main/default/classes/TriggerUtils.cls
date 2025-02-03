/**
 * @description       :
 * @author            : unknown
 * @group             :
 * @last modified on  : 2025-02-03
 * @last modified by  : unknown
**/
public class TriggerUtils {
    /**
    * @description
    * @author unknown | 2023-01-11
    * @param Schema.SObjectType sObjectType
    * @param Account newValue
    * @param Account oldValue
    * @return Set<String>
    **/
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

    /**
    * Check if field as changed (insert and undelete are handled as changed)
    * @author unknown | 2023-01-11
    * @param Object oldValue
    * @param Object newValue
    * @return Boolean
    **/
    public static Boolean hasFieldChanged(Object oldValue, Object newValue) {
        if (!Trigger.isExecuting) {
            return false;
        }
        return Trigger.isInsert || Trigger.isUndelete ? true : oldValue != newValue;
    }
}