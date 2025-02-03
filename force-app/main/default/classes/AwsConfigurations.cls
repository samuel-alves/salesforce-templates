/**
 * @File Name          : AwsConfigurations.cls
 * @Description        :
 * @Author             : unknown
 * @Group              :
 * @Last Modified By   : unknown
 * @Last Modified On   : 11/22/2019, 5:41:24 PM
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    11/22/2019   unknown     Initial Version
**/
public class AwsConfigurations {
    // IAM User credentials
    public String IamSecretAccessKey;
    public String IamAccessKeyId;

    // enable/disable debug logs
    public Boolean DebugMode;

    // used to calculate canonical Url
    // sts.amazonaws.com
    public String StsHost;

    // https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html
    // default/global region --> us-east-1
    public String StsRegion;

    // duration in seconds (e.g, 3600)
    public Integer StsSessionTokenDuration;

    // https://sts.amazonaws.com
    public String StsEndpoint;

    // S3 Bucket name
    public String S3Bucket;

    // S3 Bucket region
    public String S3Region; //eu-central-1

    // https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html
    public String S3CannedAcl; // "authenticated-read"

    // Template to create S3 object link
    // https://{{BUCKET_NAME}}.s3.{{BUCKET_REGION}}.amazonaws.com/{{FILE_NAME}}
    public String S3UrlStringTemplate;

    public Integer S3SignedUrlExpiryTime; // 3600
}