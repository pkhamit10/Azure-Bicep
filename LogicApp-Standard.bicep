param pLogicAppName string = 'azbicepdevfrlogicapppk'
param Location string = resourceGroup().location
param pStorageAccountName string = 'azbicepdevfrstoragepk'
param pAppInsightsName string = 'azbicepdevfrappinsightspk'
param pfileShare string = 'fapppkfileshare'
param pAppServicePlanName string = 'azbicepdevfrappserviceplanpk'

module storage_module 'StorageAccount.bicep' = {
  name: 'storage_module'
  params: {
    pStorageAccountName: pStorageAccountName
    pLocation: Location
    pfileShareName: pfileShare
  }
}

resource storageaccount 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: pStorageAccountName
}

resource logicApp_Standard 'Microsoft.Web/sites@2025-03-01' = {
  location: resourceGroup().location
  name: pLogicAppName
  kind: 'functionapp,linux,workflowapp'
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

resource appsetting 'Microsoft.Web/sites/config@2025-03-01' = {
  name: 'appsettings'
  parent: logicApp_Standard
  properties: {
    App_Kind: 'workflowapp'
    APPINSIGHTS_INSTRUMENTATIONKEY: appinsights_module.outputs.oAppInsightsInstrumentationKey
    FUNCTIONS_EXTENSION_VERSION: '~4' // logic app depends on functionapp runtime
    FUNCTIONS_WORKER_RUNTIME: 'node'
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING: 'DefaultEndpointsProtocol=https;AccountName=${pStorageAccountName};AccountKey=${storageaccount.listKeys().keys[0].value};EndpointSuffix=core.windows.net'
    WEBSITE_CONTENTSHARE: pfileShare
  }
}

resource loganalytics_workspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' = {
  name: '${pLogicAppName}-LogAnalytics'
  location: Location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource logicapps_diagnostic 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${pLogicAppName}-DiagnosticSettings'
  scope: logicApp_Standard
  properties: {
    workspaceId: loganalytics_workspace.id
    logs: [
      {
        categoryGroup: 'AllLogs'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
  }
}
