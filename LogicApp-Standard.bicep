param pLogicAppName string 
param Location string = resourceGroup().location
param pStorageAccountName string 
param pAppInsightsName string
param pfileShare string
param pAppServicePlanName string

resource logicApp_Strandard 'Microsoft.Web/sites@2025-03-01' = {
  location: resourceGroup().location
  name: pLogicAppName
  kind: 'FunctionApp,workflowapp'
  properties: {
    serverFarmId: appserviceplan.outputs.oAppServicePlanId
    siteConfig: {
      netFrameworkVersion: 'v4.8'
      functionsRuntimeScaleMonitoringEnabled: false
    }
  }
  dependsOn: [
    appinsights_module
    storage_module
  ]
}

module appserviceplan 'AppServicePlan-Linux.bicep' = {
  name: 'appserviceplan'
  params: {
    pAppServicePlanName: pAppServicePlanName
    pLocation: Location
  }
}

module appinsights_module './modules/AppInsights.bicep' = {
  name: 'appinsights_module'
  params: {
    pAppInsightsName: pAppInsightsName
    pLocation: Location
  }
}

resource storageaccount 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: pStorageAccountName
}

module storage_module 'StorageAccount.bicep' = {
  name: 'storage_module'
  params: {
    pStorageAccountName: pStorageAccountName
    pLocation: Location
    pfileShareName: pfileShare
  }
}

resource appsetting 'Microsoft.Web/sites/config@2025-03-01' = {
  name: 'appsettings'
  parent: logicApp_Strandard
  properties: {
    App_Kind: 'workflowapp'
    APPINSIGHTS_INSTRUMENTATIONKEY: appinsights_module.outputs.oAppInsightsInstrumentationKey
    FUNCTIONS_EXTENSION_VERSION: '~4' // logic app depends on functionapp runtime
    FUNCTIONS_WORKER_RUNTIME: 'node'
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING: 'DefaultEndpointsProtocol=https;AccountName=${pStorageAccountName};AccountKey=${storageaccount.listKeys().keys[0].value};EndpointSuffix=core.windows.net'
    WEBSITE_CONTENTSHARE: pfileShare
  }
}
