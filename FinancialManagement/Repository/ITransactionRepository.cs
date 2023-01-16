using FinancialManagement.DTO;
using FinancialManagement.Models;

namespace FinancialManagement.Repository
{
    public interface ITransactionRepository
    {
        Task<IEnumerable<FinancialTransaction>> FetchAll();
        Task<FinancialTransaction> FetchById(int id);
        Task<FinancialTransaction> CreateTransaction(FinancialTransaction financialTransaction);
        Task DeleteTransaction(int transactionId);
        Task UpdateTransaction(UpdateTransactionDTO updatedTransaction);
    }
}