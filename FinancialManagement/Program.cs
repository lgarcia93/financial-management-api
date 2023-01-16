using AWS.Logger.SeriLog;
using FinancialManagement.Infra.Dapper;
using FinancialManagement.Infra.S3;
using FinancialManagement.Repository;
using FinancialManagement.Service;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Serilog;
using Serilog.Formatting.Compact;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Host.UseSerilog((ctx, lc) =>
{
    lc
        .ReadFrom.Configuration(ctx.Configuration)
        .WriteTo.AWSSeriLog(
            configuration: ctx.Configuration,
            textFormatter: new RenderedCompactJsonFormatter());
});

builder.Services.TryAddSingleton<DapperContext>();
builder.Services.TryAddScoped<IS3Service, S3Service>();
builder.Services.TryAddScoped<ITransactionService, TransactionService>();
builder.Services.TryAddScoped<ITransactionRepository, TransactionRepository>();

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    // c.OperationFilter<SwaggerFileOperationFilter>();
});

var app = builder.Build();

app.MapGet("/", () => "Health Check");

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment() || true)
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();