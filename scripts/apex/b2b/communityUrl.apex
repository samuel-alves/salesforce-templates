public String getCommunityURL(String communityId){
    String base = Network.getLoginUrl(communityId);
    base = base.replace('/login', '');
    return base;
}

String storeName = 'My Store';
Id communityId = [SELECT Id, Name, UrlPathPrefix FROM Network WHERE Name = :storeName LIMIT 1].Id;

System.debug(getCommunityURL(communityId));