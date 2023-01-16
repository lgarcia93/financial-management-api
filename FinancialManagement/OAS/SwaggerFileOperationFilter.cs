using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace FinancialManagement.OAS;

public class SwaggerFileOperationFilter : IOperationFilter  
{  
    public void Apply(OpenApiOperation operation, OperationFilterContext context)  
    {  
        var fileUploadMime = "multipart/form-data";  
        if (operation.RequestBody == null || !operation.RequestBody.Content.Any(x => x.Key.Equals(fileUploadMime, StringComparison.InvariantCultureIgnoreCase)))  
            return;  
  
        var fileParams = context.MethodInfo.GetParameters().Where(p => p.ParameterType == typeof(IFormFile));
        Dictionary<string, OpenApiSchema> dictionary = new Dictionary<string, OpenApiSchema>();

        foreach (var param in fileParams)
        {
            dictionary.Add(param.Name ?? "", new OpenApiSchema() { Type = "string", Format = "binary" });
        }
        
        operation.RequestBody.Content[fileUploadMime].Schema.Properties = dictionary;  
    }  
}  
