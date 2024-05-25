/**
 * @description       : Email Template Selector
 * @author            : https://smukov.github.io/blog/2019/11/24/Automatic-Email-Template-Selection-in-Case-Feed/
 * @group             :
 * @last modified on  : 2024-03-07
 * @last modified by  : samuelalves@loba.com
**/
global class EmailTemplateSelector implements QuickAction.QuickActionDefaultsHandler {
  global EmailTemplateSelector() { }

  global void onInitDefaults(QuickAction.QuickActionDefaults[] defaultsList) {
    for (Integer j = 0; j < defaultsList.size(); j++) {
      QuickAction.QuickActionDefaults defaults = defaultsList.get(j);

      // Check if the quick action is the standard case feed `SendEmail` action
      if (
        defaults instanceof QuickAction.SendEmailQuickActionDefaults &&
        defaults.getTargetSObject().getSObjectType() == EmailMessage.sObjectType &&
        defaults.getActionType().equals('SendEmail')
      ) {
        String actionName = defaults.getActionName();
        Id contextId = defaults.getContextId();

        // check if the related object is a Case
        // and process it in the same way no matter if it's
        // a `SendEmail`, `Reply`, or `Reply All` action
        if (
          (actionName.equals('Case.SendEmail') ||
           actionName.equals('EmailMessage._Reply') ||
           actionName.equals('EmailMessage._ReplyAll')) &&
           contextId != null &&
           contextId.getSobjectType() == Case.sObjectType
        ) {
          applySendEmailDefaultsForCase((QuickAction.SendEmailQuickActionDefaults) defaults);
          break;
        }
      }
    }
  }

  private void applySendEmailDefaultsForCase(QuickAction.SendEmailQuickActionDefaults sendEmailDefaults) {
    // query for the relevant data on the related Case record (e.g. Type field)
    Case c = [
      SELECT Type
      FROM Case
      WHERE Id = :sendEmailDefaults.getContextId()
    ];

    // implement some logic to obtain the correct `emailTemplateId` && `validatedFromAddress`,
    // based on the Case record fields (preferably using a Custom Metadata Type)

    // apply the default email template
    sendEmailDefaults.setTemplateId(emailTemplateId);
    sendEmailDefaults.setInsertTemplateBody(true);
    sendEmailDefaults.setIgnoreTemplateSubject(false);

    // apply other field defaults to EmailMessage (e.g. ValidatedFromAddress)
    EmailMessage emailMessage = (EmailMessage) sendEmailDefaults.getTargetSObject();
    emailMessage.ValidatedFromAddress = validatedFromAddress;
  }
}