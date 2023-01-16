namespace FinancialManagement.Infra.S3;

public interface IS3Service
{
    Task SendFile(IFormFile file, string bucketName, string customFileName);
}