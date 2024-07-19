/**
 * Execture Batch Operations
 */
global with sharing class BatchOperations implements Database.Batchable<SObject>, Schedulable {
    private String query;
    private String operation;
    private Map<String, Object> newValues;

    // input set of ids
    private Set<Id> querySimpleIdSet;

    /**
     * @param query     String  Query to execute
     * @param operation String  Operation to execute (update OR delete)
     * @param newValues Map     Key/value pair of fields to update
     */
    global BatchOperations(String query, String operation, Map<String, Object> newValues, Set<Id> querySimpleIdSet) {
        this.query = query;
        this.operation = operation;
        this.newValues = newValues;
        this.querySimpleIdSet = querySimpleIdSet;

        System.debug('Query: ' + this.query);
        System.debug('Operation: ' + this.operation);
        System.debug('New Values: ' + this.newValues);
        System.debug('Query Simple Id Set: ' + this.querySimpleIdSet);
    }

    global Database.querylocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(this.query);
    }

    /**
     * Database.execute
     * @override 
     */
    global void execute(Database.BatchableContext BC, List<SObject> rows) {
        if(operation.equalsIgnoreCase('delete')) {
            delete rows;
        } else if (operation.equalsIgnoreCase('update')) {
            for (SObject c : rows) {
                updateValues(c);
            }

            update rows;
        }
    }
    
    /**
     * Schedulable.execute
     * @override 
     */
    global void execute(SchedulableContext sc) {
        ID batchprocessid = Database.executeBatch(new BatchOperations(this.query, this.operation, this.newValues, this.querySimpleIdSet));
        System.debug('BatchOperations.execute (schedulable): batchprocessid: ' + batchprocessid);
    }

    global void finish(Database.BatchableContext BC) {
    }

    private void updateValues(SObject obj) {
        if(newValues == null) return;
        for(String key : newValues.keyset()) {
            obj.put(key, newValues.get(key));
        }
    }
}