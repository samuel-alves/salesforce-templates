trigger ManageContentDistribution on ContentDistribution (after insert, after update) {

	Set<Id> versionId = new Set<Id>();

	for(ContentDistribution cd : trigger.new) {
		versionId.add(cd.ContentVersionId);
	}

	// urls are generated after, then we must query the object to get these values
	Map<Id, ContentDistribution> dists = new Map<Id, ContentDistribution>([SELECT Id, ContentDownloadUrl FROM ContentDistribution WHERE Id IN :trigger.newMap.keyset()]);
	Map<Id, ContentVersion> versions = new Map<Id, ContentVersion>([SELECT Id, ContentDocumentId, Download_Link__c FROM ContentVersion WHERE Id IN :versionId]);

	for(ContentDistribution cd : trigger.new) {
		if(versions.get(cd.ContentVersionId) == null) continue;
		versions.get(cd.ContentVersionId).Download_Link__c = dists.get(cd.Id).ContentDownloadUrl;
	}

	if(versions.values().size() > 0) update versions.values();
}