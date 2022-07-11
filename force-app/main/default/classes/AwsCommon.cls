/**
 * @File Name          : AWSCommon.cls
 * @Description        : 
 * @Author             : samuel.f.alves@outlook.com
 * @Group              : 
 * @Last Modified By   : samuel.f.alves@outlook.com
 * @Last Modified On   : 11/22/2019, 5:41:24 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/19/2019   samuel.f.alves@outlook.com     Initial Version
**/
public without sharing class AwsCommon {
	
    /**
    * @description 
    * @author samuel.f.alves@outlook.com | 11/20/2019 
    * @param String method 
    * @param String parameters 
    * @param String host 
    * @param Datetime xAmzDate 
    * @return String 
	* 
	* Note: @parameters must be alphabetically ordered
    **/
    public static String getCanonicUrl(String method, String parameters, String host, Datetime xAmzDate){
		String xAmzDateStr = xAmzDate.formatGMT('YYYYMMdd\'T\'HHmmss\'Z\'');

		String canonicalUrl = '';
		canonicalUrl += method + '\n' ;
		canonicalUrl += '/\n' ;
		canonicalUrl += parameters + '\n' ; // Query parameters
		canonicalUrl += 'host:' + host + '\n' ;
		canonicalUrl += 'x-amz-date:' + xAmzDateStr + '\n' ;
		canonicalUrl += '\nhost;x-amz-date\n' ;	// Signed headers
		canonicalUrl += 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'; // empty body hash
	
		return canonicalUrl;
	}
	
	/**
	* @description 
	* @author samuel.f.alves@outlook.com | 11/20/2019 
	* @param Datetime xAmzDate 
	* @param String canonicalUrlHash 
	* @return String 
	**/
	public static String getStringToSign(Datetime xAmzDate, String canonicalUrlHash) {
		String xAmzDatetimeStr = xAmzDate.formatGMT('YYYYMMdd\'T\'HHmmss\'Z\'');
		String xAmzDateStr = xAmzDate.formatGMT('YYYYMMdd');

		String stringToSign = '';
		stringToSign += 'AWS4-HMAC-SHA256\n';
		stringToSign += xAmzDatetimeStr + '\n';
		stringToSign += xAmzDateStr + '/us-east-1/sts/aws4_request\n';
		stringToSign += canonicalUrlHash;

		return stringToSign;
	}

	/**
	* @description 
	* @author samuel.f.alves@outlook.com | 11/20/2019 
	* @param String key 
	* @param String dateStamp 
	* @param String regionName 
	* @param String serviceName 
	* @return Blob 
	**/
	public static Blob getSignatureKey(String key, String dateStamp, String regionName, String serviceName) {
		String kSecret = 'AWS4' + key;
		Blob kDate = Crypto.generateMac('hmacSHA256', Blob.valueOf(dateStamp), Blob.valueOf(kSecret));
		Blob kRegion = Crypto.generateMac('hmacSHA256', Blob.valueOf(regionName), kDate);
		Blob kService = Crypto.generateMac('hmacSHA256', Blob.valueOf(serviceName), kRegion);
		Blob kSigning = Crypto.generateMac('hmacSHA256',Blob.valueOf( 'aws4_request'), kService);

		return kSigning;
	}

    /**
    * @description 
    * @author samuel.f.alves@outlook.com | 11/20/2019 
    * @param String input 
    * @return String 
    **/
    public static String sha256(String input) {
        return EncodingUtil.convertToHex(Crypto.generateDigest('SHA256', Blob.valueOf(input)));
    }

    /**
    * @description 
    * @author samuel.f.alves@outlook.com | 11/20/2019 
    * @param Blob messageToSign 
    * @param Blob signatureKey 
    * @return String 
    **/
    public static String hmacSha256(Blob messageToSign, Blob signatureKey) {
        return EncodingUtil.convertToHex(Crypto.generateMac('hmacSHA256', messageToSign, signatureKey));
    }
}