using System.Data;
using Amazon;
using Amazon.Runtime;
using Amazon.SimpleSystemsManagement;
using Amazon.SimpleSystemsManagement.Model;
using MySqlConnector;

namespace FinancialManagement.Infra.Dapper;

public class DapperContext
{
    private readonly AmazonSimpleSystemsManagementClient _awsSsmClient;

    public DapperContext()
    {
        _awsSsmClient = new AmazonSimpleSystemsManagementClient(
            FallbackCredentialsFactory.GetCredentials(),
            RegionEndpoint.USEast1
        );

    }
    private async Task<string> GetParameterByName(string parameterName)
    {
  
        var request = new GetParameterRequest()
        {
            Name = parameterName
        };
        var result = await _awsSsmClient.GetParameterAsync(request);

        return result.Parameter.Value;
    }
    
    public async Task<IDbConnection> CreateConnection()
    {

        var rdsAddress = await GetParameterByName("rds-address-financial-management");
        var rdsUser = await GetParameterByName("rds-user-financial-management");
        var rdsPassword = await GetParameterByName("rds-password-financial-management");
      
       var connString =
            $"Server={rdsAddress};port=3306;Database=dbfinancialtransaction;User Id={rdsUser};Password={rdsPassword};Ssl Mode=None";
        return new MySqlConnection(connString);
    }
}