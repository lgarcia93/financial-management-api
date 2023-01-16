using FinancialManagement.DTO;
using FinancialManagement.Infra.S3;
using FinancialManagement.Models;
using FinancialManagement.Repository;

namespace FinancialManagement.Service;

public class TransactionService : ITransactionService
{
    private readonly ITransactionRepository _transactionRepository;

    private readonly IS3Service _s3Service;
    private readonly IConfiguration _configuration;
    public TransactionService(ITransactionRepository transactionRepository, IS3Service s3Service, IConfiguration configuration)
    {
        _transactionRepository = transactionRepository;
        _s3Service = s3Service;
        _configuration = configuration;
    }
    
    public Task<IEnumerable<FinancialTransaction>> FetchAll()
    {
        return _transactionRepository.FetchAll();
    }

    public Task<FinancialTransaction> FetchById(int id)
    {
        return _transactionRepository.FetchById(id);
    }

    public async Task<FinancialTransaction> CreateTransaction(CreateTransactionDto financialTransactionDto)
    {
        var splitedName = financialTransactionDto.File.FileName.Split(".");
        var extension = splitedName.GetValue(1);
        var formattedExtension = extension != null ? $".{extension}" : "";
        
        var fileName = $"{Guid.NewGuid().ToString()}{formattedExtension}";
        
        var bucketName = _configuration.GetSection("S3BucketName").Value;
        
        await _s3Service.SendFile(financialTransactionDto.File, bucketName, fileName);

        var financialTransaction = new FinancialTransaction
        {
            Category = new Category{Id = financialTransactionDto.CategoryId},
            Description = financialTransactionDto.Description,
            Type = financialTransactionDto.Type,
            Value = financialTransactionDto.Value,
            FileURL = $"https://{bucketName}.s3.amazonaws.com/{fileName}"
        };
        
        var transaction = await _transactionRepository.CreateTransaction(financialTransaction);

       
        
        return transaction;
    }
    
    public Task UpdateTransaction(UpdateTransactionDTO updatedTransaction)
    {
        return _transactionRepository.UpdateTransaction(updatedTransaction);
    }
    
    public Task DeleteTransaction(int transactionId)
    {
        return _transactionRepository.DeleteTransaction(transactionId);
    }

}