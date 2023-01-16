using FinancialManagement.DTO;
using FinancialManagement.Service;
using Microsoft.AspNetCore.Mvc;

namespace FinancialManagement.Controllers;

[ApiController]
[Route("[controller]")]
public class TransactionController : ControllerBase
{
    private readonly ITransactionService _transactionService;

    private ILogger<TransactionController> _logger;

    public TransactionController(ITransactionService transactionService, ILogger<TransactionController> logger)
    {
        _transactionService = transactionService;
        _logger = logger;
    }

    [HttpGet]
    public async Task<IActionResult> Get()
    {
        
        _logger.LogInformation(
            "Request to fetch all Ids");
        return Ok(await _transactionService.FetchAll());
    }
    
    [HttpGet("{id}", Name = "GetTransactionById")]
    public async Task<IActionResult> GetById([FromRoute] int id)
    {
        _logger.LogInformation(
            "Request Transaction with Id {Id}", id);
        return Ok(await _transactionService.FetchById(id));
    }
    
    [HttpPost]
    public async Task<IActionResult> Create([FromForm] CreateTransactionDto transaction)
    {
        try
        {
            _logger.LogInformation(
                "Request to create Transaction with Description {Description}, Value {Value}, Type {Type}, Category {Category}", transaction.Description, transaction.Value, transaction.Type, transaction.CategoryId);
            var newTransaction = await _transactionService.CreateTransaction(transaction);
            
            return CreatedAtRoute("GetTransactionById", new { id = newTransaction.Id }, newTransaction);
        }
        catch (Exception ex)
        {
            return StatusCode(500, ex.Message);
        }
    }

    [HttpPut]
    public async Task<IActionResult> Update([FromBody] UpdateTransactionDTO updatedTransaction)
    {
        _logger.LogInformation(
            "Request to update Transaction with Id {Id} with Description {Description}, Value {Value}, Type {Type}, Category {Category}", 
            updatedTransaction.Id,
            updatedTransaction.Description, 
            updatedTransaction.Value,
            updatedTransaction.Type,
            updatedTransaction.CategoryId
            );
        
        await _transactionService.UpdateTransaction(updatedTransaction);

        return Ok();
    }
    
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete([FromRoute] int id)
    {
        _logger.LogInformation(
            "Request to delete Transaction with Id {Id}", 
            id
        );
        await _transactionService.DeleteTransaction(id);

        return Ok();
    }
}