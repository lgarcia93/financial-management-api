using System.Text.Json.Serialization;
using FinancialManagement.Models;

namespace FinancialManagement.DTO;

public class CreateTransactionDto
{
    public decimal Value { get; set; }
    public string Description { get; set; }
    
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public TransactionType Type { get; set; }
    public int CategoryId { get; set; }
    public IFormFile File { get; set; }
}