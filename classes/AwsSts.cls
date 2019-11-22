/**
 * @File Name          : AwsSts.cls
 * @Description        :
 * @Author             : samuel.f.alves@outlook.com
 * @Group              :
 * @Last Modified By   : samuel.f.alves@outlook.com
 * @Last Modified On   : 11/22/2019, 5:41:24 PM
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    11/19/2019   samuel.f.alves@outlook.com     Initial Version
 **/
public without sharing class AwsSts {
    private static AwsConfigurations awsConfigurations;
    private static GetSessionTokenResponse sessionToken;

    public static AwsConfigurations getAwsConfigurations() {
        return awsConfigurations != null ? awsConfigurations : AwsConfigurations.getOrgDefaults();
    }

    public static GetSessionTokenResponse getTemporaryCredentials() {
        printLog('AwsSts.getTemporaryCredentials()');

        if (sessionToken != null) {
            return sessionToken;
        }

        Datetime now = System.now();

        String xAmzDate = now.formatGMT('YYYYMMdd\'T\'HHmmss\'Z\'');
        String xAmzDateOnly = now.formatGMT('YYYYMMdd');
        String host = getAwsConfigurations().StsHost; // 'sts.amazonaws.com';
        String region = getAwsConfigurations().StsRegion; // 'us-east-1';
        Integer tokenDuration = (Integer) getAwsConfigurations().StsSessionTokenDuration; // 1800
        
        // Endpoint
        String endpoint = 'https://' + host; //getAwsConfigurations().StsEndpoint;
        String endpointParams = 'Action=GetSessionToken&DurationSeconds=' + tokenDuration + '&Version=2011-06-15';

        // Calculate request signature
        // https://docs.aws.amazon.com/general/latest/gr/signature-v4-test-suite.html
        String canonicalUrl = AwsCommon.getCanonicUrl('POST', endpointParams, host, now);
        String canonicalUrlHash = AwsCommon.sha256(canonicalUrl);
        String stringToSign = AwsCommon.getStringToSign(now, canonicalUrlHash);
        Blob signatureKey = AwsCommon.getSignatureKey(getAwsConfigurations().IamSecretAccessKey, xAmzDateOnly, region, 'sts');
        String signature = AwsCommon.hmacSha256(Blob.valueOf(stringToSign), signatureKey);

        // Preapares authorization header
        String authorization = 'AWS4-HMAC-SHA256 Credential=' + getAwsConfigurations().IamAccessKeyId + '/' + xAmzDateOnly + '/' +region + '/sts/aws4_request, SignedHeaders=host;x-amz-date, Signature=' + signature;

        printLog('canonicalUrlHash:' + canonicalUrlHash);
        printLog('authorization:' + authorization);

        // Make request
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(endpoint + '?' + endpointParams);
        req.setHeader('X-Amz-Date', xAmzDate);
        req.setHeader('Authorization', authorization);

        HttpResponse res = http.send(req);

        printLog('res.statusCode: ' + res.getStatusCode());

        if (res.getStatusCode() == 200) {
            String jsonContent = XmlParser.xmlToJson(res.getBody());
            GetSessionTokenResponse sessionToken = (GetSessionTokenResponse) JSON.deserialize(jsonContent, GetSessionTokenResponse.class);

            printLog('sessionToken: ' + sessionToken);

            return sessionToken;
        } else {
            String jsonContent = XmlParser.xmlToJson(res.getBody());
            ErrorResponse sessionToken = (ErrorResponse) JSON.deserialize(jsonContent, ErrorResponse.class);

            return null;
        }
    }

    public static void printLog(String message) {
        if (getAwsConfigurations().DebugMode) System.debug(message);
    }

    public class ErrorResponse {
        public ErrorResponseNode ErrorResponse;
    }

    public class ErrorResponseNode {
        public ErrorNode Error;
        public String RequestId;
    }

    public class ErrorNode {
        public String Type;
        public String Code;
        public String Message;
    }

    public class GetSessionTokenResponse {
        public GetSessionTokenResponseNode GetSessionTokenResponse;
    }

    public class GetSessionTokenResponseNode {
        public GetSessionTokenResultNode GetSessionTokenResult;
        public ResponseMetadataNode ResponseMetadata;
    }

    public class GetSessionTokenResultNode {
        public CredentialsNode Credentials;
    }

    public class ResponseMetadataNode {
        public String RequestId;
    }

    public class CredentialsNode {
        public String AccessKeyId;
        public String SecretAccessKey;
        public String SessionToken;
        public Datetime Expiration;
    }
}