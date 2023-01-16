# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

WORKDIR /app

COPY ./FinancialManagement/*.csproj ./FinancialManagement/

RUN dotnet restore ./FinancialManagement

COPY ./FinancialManagement/ ./FinancialManagement/

RUN dotnet publish ./FinancialManagement -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .

EXPOSE 5000

ENV ASPNETCORE_URLS http://+:5000

ENTRYPOINT ["dotnet", "FinancialManagement.dll"]