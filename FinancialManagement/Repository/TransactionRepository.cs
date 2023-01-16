using System.Data;
using Dapper;
using FinancialManagement.DTO;
using FinancialManagement.Infra.Dapper;
using FinancialManagement.Models;

namespace FinancialManagement.Repository;

public class TransactionRepository : ITransactionRepository
{
    private readonly DapperContext _context;

    public TransactionRepository(DapperContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<FinancialTransaction>> FetchAll()
    {
        var query =
            "SELECT ft.Id, ft.Value, ft.Description, ft.Date, ft.Type, ft.FileURL, c.Id, c.Description FROM FinancialTransaction " +
            "ft JOIN Category c ON ft.Category_Id = c.Id";

        using var connection = await _context.CreateConnection();

        var transactions = await connection.QueryAsync<FinancialTransaction, Category, FinancialTransaction>(query,
            (transaction, category) =>
            {
                transaction.Category = category;

                return transaction;
            });

        return transactions.ToList();
    }

    public async Task<FinancialTransaction> FetchById(int id)
    {
        var query =
            "SELECT ft.Id, ft.Value, ft.Description, ft.Date, ft.Type, ft.FileURL, c.Id, c.Description FROM FinancialTransaction " +
            "ft JOIN Category c ON ft.Category_Id = c.Id where ft.Id = @Id";

        using var connection = await _context.CreateConnection();

        var transactions = await connection.QueryAsync<FinancialTransaction, Category, FinancialTransaction>(query,
            (transaction, category) =>
            {
                transaction.Category = category;

                return transaction;
            }, new {Id = id});

        return transactions.FirstOrDefault()!;
    }

    public async Task<FinancialTransaction> CreateTransaction(FinancialTransaction financialTransaction)
    {
        var query =
            "INSERT INTO FinancialTransaction (Value, Description, Date, Type, Category_Id, FileURL) VALUES (@Value, @Description, @Date, @TransactionType, @CategoryId, @FileURL); " +
            "select LAST_INSERT_ID();";

        var now = DateTime.Now;
        
        var parameters = new DynamicParameters();
        parameters.Add("Value", financialTransaction.Value, DbType.Decimal);
        parameters.Add("Description", financialTransaction.Description, DbType.String);
        parameters.Add("Date", now, DbType.DateTime);
        parameters.Add("TransactionType", financialTransaction.Type.ToString(), DbType.String);
        parameters.Add("CategoryId", financialTransaction.Category.Id, DbType.Int64);
        parameters.Add("FileURL", financialTransaction.FileURL, DbType.String);

        using var connection = await _context.CreateConnection();
        
        var createdId = await connection.QuerySingleAsync<int>(query, parameters);

        financialTransaction.Id = createdId;
        financialTransaction.Date = now;

        return financialTransaction;
    }

    public async Task UpdateTransaction(UpdateTransactionDTO updatedTransaction)
    {
        var query =
            "UPDATE FinancialTransaction SET Value = @Value, Description = @Description, Type = @Type, Category_Id = @CategoryId where Id = @Id";
   
        var parameters = new DynamicParameters();
        parameters.Add("Id", updatedTransaction.Id, DbType.Int64);
        parameters.Add("Value", updatedTransaction.Value, DbType.Decimal);
        parameters.Add("Description", updatedTransaction.Description, DbType.String);
        parameters.Add("Type", updatedTransaction.Type, DbType.String);
        parameters.Add("CategoryId", updatedTransaction.CategoryId, DbType.Int64);

        using var connection = await _context.CreateConnection();

        await connection.ExecuteAsync(query, parameters);
    }
    
    public async Task DeleteTransaction(int transactionId)
    {
        var query =
            "DELETE FROM FinancialTransaction where Id = @Id";
   
        var parameters = new DynamicParameters();
        parameters.Add("Id", transactionId, DbType.Int64);
      
        using var connection = await _context.CreateConnection();

        await connection.ExecuteAsync(query, parameters);
    }

   
}