/**
 * @description       :
 * @author            : unknown
 * @group             :
 * @last modified on  : 2025-02-03
 * @last modified by  : unknown
**/
Set<Id> userIds = new Set<Id>{UserInfo.getUserId()};
Map<Id, Group> queueIds = new Map<Id, Group>();
Map<Id, Group> groupIds = new Map<Id, Group>();

void getQueueAndGroupIds(Set<Id> userOrGroupId, Map<Id, Group> queueIds, Map<Id, Group> groupIds, Integer depth) {
    if (depth != null) {
        depth--;
        if (depth < 0) {
            return;
        }
    }
    Set<Id> nextGroupIds = new Set<Id>();
    List<GroupMember> groupMembers = [SELECT Id, GroupId, Group.Name, Group.Type, UserOrGroupId FROM GroupMember WHERE UserOrGroupId IN :userOrGroupId];

    for (GroupMember gm : groupMembers) {
        if (gm.Group.Type == 'Regular') {
            nextGroupIds.add(gm.GroupId);
            groupIds.put(gm.GroupId, gm.Group);
        } else if (gm.Group.Type == 'Queue') {
            queueIds.put(gm.GroupId, gm.Group);
        }
    }

    if (!nextGroupIds.isEmpty()) {
        getQueueAndGroupIds(nextGroupIds, queueIds, groupIds, depth);
    }
}


getQueueAndGroupIds(userIds, queueIds, groupIds, null);

System.debug(queueIds);
System.debug(groupIds);