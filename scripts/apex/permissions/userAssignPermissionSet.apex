/**
 * @description       : Assign Permission Set To Users In Apex Salesforce
 * https://www.levelupsalesforce.com/assign-permission-set-to-users-in-apex-salesforce
 *
 * @author            : samuelalves@loba.pt
 * @group             :
 * @last modified on  : 2023-01-02
 * @last modified by  : samuelalves@loba.pt
**/

public static void assignPermissionSet(Users[] users) {

    //Typically these would be set in a constant class
    String internalBusinessName = 'Internal_Business';
    String consultantPermissionName = 'Consultant_Permissions';

    //Store permission set Ids
    Id internalBusinessPermissionId;
    Id consultantPermissionId;

    for(PermissionSet permission: [SELECT Id, Name FROM PermissionSet WHERE Name =: internalBusinessName OR Name =: consultantPermissionName]){

        if(permission.name ==  internalBusinessName){
            internalBusinessPermissionId = permission.Id;
        }else if(permission.name == consultantPermissionName){
            consultantPermissionId = permission.Id;
        }
    }


    //Here we will create a list of permission assignments for the user records
    List<PermissionSetAssignment> permissionSetAssignments = new List<PermissionSetAssignment>();

    for(User userRecord: users){
        PermissionSetAssignment permissionSetAssignment = new PermissionSetAssignment();

        //Check if the user is a consultant
        if(userRecord.Username.endsWith('.consultant')){
            //Set permission id to consultant permission set id
            permissionSetAssignment.PermissionSetId = consultantPermissionId;

        }else{
            //We are dealing with an internal business user
            permissionSetAssignment.PermissionSetId = internalBusinessPermissionId;
        }
        //Assign permission set to user
        permissionSetAssignment.AssigneeId = userRecord.Id;

        permissionSetAssignments.add(permissionSetAssignment);
    }

    insert permissionSetAssignments;
}