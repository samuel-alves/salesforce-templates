/**
 * @File Name          : FileUtils.cls
 * @Description        :
 * @Author             : unknown
 * @Group              :
 * @Last Modified By   : unknown
 * @Last Modified On   : 3/2/2020, 4:30:12 PM
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    3/2/2020   unknown     Initial Version
**/
public class FileUtils {

    public class FileInfo {
        private String title;
        private String pathOnClient; // path with extension (to enable preview)
        private String dataBase64;   // data URL
        private Blob data;
        public String downloadUrl;

        public FileInfo(String title, String pathOnClient, String dataBase64) {
            this.title = title;
            this.pathOnClient = pathOnClient;
            this.dataBase64 = dataBase64;
        }

        public FileInfo(String title, String pathOnClient, Blob data) {
            this.title = title;
            this.pathOnClient = pathOnClient;
            this.data = data;
        }

        public Blob getData() {
            if (this.data == null && dataBase64 != null) {
                this.data = EncodingUtil.base64Decode(fileInfo.dataBase64.subStringAfter('base64,'));
            }

            return this.data;
        }
    }

    public static FileInfo createFileAttachment(Id relatedObjectId, FileInfo fileInfo) {
        ContentVersion newVersion = new ContentVersion();
        newVersion.Title = fileInfo.title;
        newVersion.pathOnClient = fileInfo.pathOnClient;
        newVersion.VersionData = fileInfo.getData();
        insert newVersion;

        Id contentDocumentId = [
            SELECT ContentDocumentId
            FROM ContentVersion
            WHERE Id = :newVersion.Id
        ].ContentDocumentId;

        ContentDocumentLink docLink = new ContentDocumentLink();
        docLink.ContentDocumentId = contentDocumentId;
        docLink.LinkedEntityId = relatedObjectId;
        docLink.ShareType = 'V';
        insert docLink;

        ContentDistribution distribution = new ContentDistribution();
        distribution.Name = newVersion.Title + ' ' +  Date.today();
        distribution.ContentVersionId = newVersion.Id;
        distribution.PreferencesNotifyOnVisit = false;
        distribution.PreferencesNotifyRndtnComplete = false;
        insert distribution;

        distribution = [
            SELECT Id, Name, ContentVersionId, ContentDownloadUrl
            FROM ContentDistribution
            WHERE Id = :distribution.Id
        ];

        // Output information
        fileInfo.downloadUrl = distribution.ContentDownloadUrl;

        return fileInfo;
    }
}