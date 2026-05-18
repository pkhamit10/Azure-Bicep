param pLogicAppName string 
param Location string = resourceGroup().location
param pAppServicePlanID string
param pStorageAccountName string 
param pAppInsightsName string

resource logicApp_Strandard 'Microsoft.Web/sites@2025-03-01' = {
  location: resourceGroup().location
  name: pLogicAppName
  kind: 'FunctionApp,workflowapp'
  properties: {
    serverFarmId: pAppServicePlanID // 
    siteConfig: {
      netFrameworkVersion: 'v4.8'
      functionsRuntimeScaleMonitoringEnabled: false
    }
  }
}

module appinsights_module './modules/AppInsights.bicep' = {
  name: 'appinsights_module'
  params: {
    pAppInsightsName: pAppInsightsName
    pLocation: Location
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
  }
}
