param pAppServicePlanName string 
param pAppServiceName string 
param pAppInsightsName string 
param pSqlServerName string 
param pSqlDatabaseName string 

module AppServicePlan '../AppServicePlan.bicep' = {
  name: 'deployAppServicePlan'
  params: {
    pAppServicePlanName: pAppServicePlanName
    pAppServiceName: pAppServiceName
    pInstrumentkey: AppInsights.outputs.oAppInsightsInstrumentationKey
  }
}

module SQLDatabase '../SQLDatabase.bicep' = {
  name: 'SQLDatabaseDeployment'
  params: {
    pSqlServerName: pSqlServerName
    pSqlDatabaseName: pSqlDatabaseName
  }
}

module AppInsights 'AppInsights.bicep' = {
  name: 'AppInsightsDeployment'
  params: {
    pAppInsightsName: pAppInsightsName
  }
}
