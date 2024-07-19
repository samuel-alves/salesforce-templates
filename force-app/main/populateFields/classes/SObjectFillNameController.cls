/**
 * Auto Populate fields while creating a new record in Salesforce
 * https://gist.github.com/cdeckert/4030447
 */
public class SObjectFillNameController
{
	ApexPages.StandardController stdController;
    public SObjectFillNameController(ApexPages.StandardController controller) {
		stdController = controller;
		stdController.getRecord();
    }

	public PageReference redirect()
	{
		PageReference redirectPR = new PageReference('/'+TriggerUtils.sObjectKeyPrefix.get(String.valueOf(stdController.getRecord().getSObjectType()))+'/e?');
		redirectPR.getParameters().putAll(ApexPages.currentPage().getParameters());

		redirectPR.getParameters().put('nooverride', '1');

		if(redirectPR.getParameters().containsKey('noNameValue') && redirectPR.getParameters().get('noNameValue')=='1')
		{
			redirectPR.getParameters().remove('noNameValue');
		}
		else
		{
			redirectPR.getParameters().put('Name', '– wird generiert –');
		}

		if(redirectPR.getParameters().containsKey('customRecordType'))
		{
			redirectPR.getParameters().put('RecordType', TriggerUtils.recordTypes.get(redirectPR.getParameters().get('customRecordType')));
		}


		redirectPR.getParameters().remove('save_new');
		return redirectPR;
	}

}