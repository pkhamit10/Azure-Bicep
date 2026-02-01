param pEnvironment string = 'dev'
param pAppServicePlanName string 
param pAppServiceName string 
param pAppInsightsName string 
param pSqlServerName string 
param pSqlDatabaseName string 
param padminLogin string 
param pSKUName string = (pEnvironment == 'dev') ? 'F1' : 'S1'
param pSKUCapacity int = (pEnvironment == 'dev') ? 1 : 2
resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' existing = {
  name: 'azbicep-dev-fc-kv'
  scope: resourceGroup('azbicep_common_kv_fc_rg')
}

module AppServicePlan '../AppServicePlan.bicep' = {
  name: 'deployAppServicePlan'
  params: {
    pAppServicePlanName: pAppServicePlanName
    pAppServiceName: pAppServiceName
    pInstrumentkey: AppInsights.outputs.oAppInsightsInstrumentationKey
    pSKUName: pSKUName
    pSKUCapacity: pSKUCapacity
  }
}

/* module SQLDatabase '../SQLDatabase.bicep' = {
  name: 'SQLDatabaseDeployment'
  params: {
    pSqlServerName: pSqlServerName
    pSqlDatabaseName: pSqlDatabaseName
    padminLogin: padminLogin
    padminPassword: keyVault.getSecret('sqladminpassword')
  }
} */

module AppInsights 'AppInsights.bicep' = {
  name: 'AppInsightsDeployment'
  params: {
    pAppInsightsName: pAppInsightsName
  }
}
