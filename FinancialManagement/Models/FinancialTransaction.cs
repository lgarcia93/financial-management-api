using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace FinancialManagement.Models;

public class FinancialTransaction
{   
    public int Id { get; set; }
    public decimal Value { get; set; }
    public string Description { get; set; }
    public DateTime Date { get; set; }
    
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public TransactionType Type { get; set; } 
    public Category Category { get; set; }
    public string FileURL { get; set; }
}