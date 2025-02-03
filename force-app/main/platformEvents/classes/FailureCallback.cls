/**
 * @description       :
 * https://help.salesforce.com/s/articleView?id=release-notes.rn_platform_events_publish_callbacks.htm&release=244&type=5
 * @author            : unknown
 * @group             :
 * @last modified on  : 2025-02-03
 * @last modified by  : unknown
**/
public class FailureCallback implements EventBus.EventPublishFailureCallback {
    public void onFailure(EventBus.FailureResult result) {
        // Your implementation.
        // Get event UUIDs from the result
        List<String> eventUuids = result.getEventUuids();
        // ...
    }
}
