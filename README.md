# .NET Core Financial Management API + AWS Infrastructure

## This is a simple Financial Management API project written in C# (.Net Core 6.0) which uses Terraform to provision it`s infrastructure on AWS

### Motivation

I created this project mainly to leverage many different AWS services such as ECS (Elastic Container Service) and EC2 for running containers, ECR (Elastic Container Repository) to store the Docker images, Amazon S3, Amazon MySQL RDS, Simple Systems Manager and more. 
Also, I wanted this infrastructure to be easily replicated by anyone by just using the code provided in this repository. For this purpose, I used Terraform to write Infrastructure as Code (IaC). 
It's not my intention to build a highly complex .NET Rest API, but to show how to use AWS Services to create scalable and highly available applications.

### The application

As of now, the application consists of only one controller called TransactionController, where all the REST operations on the FinancialTransaction entity can be performed. It's important noting that the user can upload files along with the FinancialTransaction data when submiting a POST request. The file will be stored in Amazon S3, and a like for the file will be stored in the FinancialTransaction table.

### Architecture

The folder Deployment/Terraform has all necessary files to recreate the application infrastructure in the AWS Cloud.
At the moment, the application consists of a Load Balancer fronting two EC2 instances (more than one for high availability) which are part of a ECS Cluster. The database adopted is Amazon RDS for MySQL.
For improve observaility, CloudWatch was used for monitoring logs generated by the application. For securely storing the database credentials the ParameterStore feature from Amazon SSM was used, so the credentials don't need to be exposed in plain text.

### Pre Requesites

- .NET Core 6.0
- Terraform CLI
- AWS CLI configured with valid credentials

### Run the project

#### Steps:

##### Create the tables
```
create table Category
(
    Id          int          not null  primary key,
    Description varchar(255) not null
);

create table FinancialTransaction
(
    Id          int auto_increment
        primary key,
    Value       decimal(10, 2)             not null,
    Description varchar(255)               not null,
    Date        datetime                   not null,
    Type        enum ('Income', 'Expense') not null,
    Category_Id int                        not null,
    FileURL     varchar(255),
    constraint FinancialTransaction_ibfk_1
        foreign key (Category_Id) references Category (Id)
)
```

```cd Deployment/Terraform && chmod a+x 777 build-images.sh && terraform apply```

This command will ask you the password and username to provision the RDS Instance. After that, it will start provisioning the resources in the AWS Cloud. The 'build-images.sh' file will build the Docker images and push it to the just provisioned ECR Repository.
