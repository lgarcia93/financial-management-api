using Amazon;
using Amazon.Runtime;
using Amazon.S3;
using Amazon.S3.Transfer;

namespace FinancialManagement.Infra.S3;

public class S3Service : IS3Service
{
    public async Task SendFile(IFormFile file,  string bucketName, string customFileName)
    {
        using var client = new AmazonS3Client(
                FallbackCredentialsFactory.GetCredentials(),
                RegionEndpoint.USEast1
            );
        await using var newMemoryStream = new MemoryStream();
        await file.CopyToAsync(newMemoryStream);

       var uploadRequest = new TransferUtilityUploadRequest
        {
            InputStream = newMemoryStream,
            Key = customFileName,
            BucketName = bucketName,
            CannedACL = S3CannedACL.PublicRead
        };

        var fileTransferUtility = new TransferUtility(client);
        await fileTransferUtility.UploadAsync(uploadRequest);
    }
}