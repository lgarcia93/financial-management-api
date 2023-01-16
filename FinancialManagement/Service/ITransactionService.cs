using FinancialManagement.DTO;
using FinancialManagement.Models;

namespace FinancialManagement.Service;

public interface ITransactionService
{
    Task<IEnumerable<FinancialTransaction>> FetchAll();
    Task<FinancialTransaction> FetchById(int id);
    Task<FinancialTransaction> CreateTransaction(CreateTransactionDto financialTransaction);
    Task UpdateTransaction(UpdateTransactionDTO updatedTransaction);
    Task DeleteTransaction(int transactionId);
}