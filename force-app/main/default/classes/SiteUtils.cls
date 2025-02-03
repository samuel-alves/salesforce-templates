/**
 * @description       :
 * @author            : unknown
 * @group             :
 * @last modified on  : 2025-02-03
 * @last modified by  : unknown
**/
public without sharing class SiteUtils {
    public static String getSiteUrl(String siteName) {
        try {
            DomainSite site = [SELECT Id, Site.Name, Domain.Domain, PathPrefix FROM DomainSite WHERE Site.Name = :siteName WITH SECURITY_ENFORCED LIMIT 1];
            return 'https://' +  site.Domain.Domain + site.PathPrefix;
        } catch(Exception e) {
            return null;
        }
    }
}