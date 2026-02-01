## Azure-Bicep
In this project, developed Azure resources such a Resource Group, App Service Plan, Web App service, Application Insights and AppInsight Configuration settings.

## ResourceGroup
Created a single **Resource Group** using Bicep template that is being deployed at subscription level and in France Central location. This Resource group is used as a logical container for resources Web App, App Service Plan, Application Insights. It helps to organize and manage these resources as a single unit. 

## AppServicePlan
Created a **AppService plan** with "Standard S1" Pricing tier using bicep template and it is deployed in the same location as the resource group. An App Service Plan is being used to provide computing resources(CPU,memory,storage) for hosting Web Apps. Multiple Web Apps can share this single App Service Plan and is cost-effective

## WebAppService
Created **Azure Web App** using Bicep template that runs on the created **App Service Plan** (`azbicep_dev_fc_asp1`). The Web App will run on the Standard S1 service plan. This web App will be used to host a .NET application. An Azure Web App is being created to provide a managed hosting environments for web apps. A Web App service requires App Service Plan for allocating compute resources like CPU, Memory and Storage. 

## Application Insights
Created **Application Insights** using Bicep template for monitoring Azure web app. It will be linked to Web app to allow real-time monitoring and is being deployed in the same region as App Service.An App Insights integrates seamlessly with Azure Web Apps and supports alerts and dashboards.It will be linked to the Web App using APPINSIGHTS_INSTRUMENTATIONKEY in app settings.

## SQL Server
A **SQL Server instance** and a **SQL Database** is created within the SQL server instance using Bicep template and a **firewall** is added to the SQL Server to define which IP addresses are allowed to connect to the SQL Server. This ensures only specific IP addresses can access the SQL server, preventing unauthorized access from external sources.

## Modules
A main module is being created and invoking the submodules by passing inputs as parameters. It allows to  configure dependencies between modules. 

## Parameters
In order to have unique names for each resources across dev, stage and prod environments, created parameters for each resources. parameters allows the infrastructure bicep templates to have generic, reusable and environment independent.

## Function app
Storage account is required to be created.