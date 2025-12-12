param pAppServicePlanName string = 'azbicep_dev_fc_asp1'
param pAppServiceName string = 'azbicep-dev-fc-webapp1'
param pAppInsightsName string = 'azbicep-dev-fc-ai1'
param pSqlServerName string = 'azbicep-dev-fc-sqlserver1'
param pSqlDatabaseName string = 'database1'

module AppServicePlan '../AppServicePlan.bicep' = {
  name: 'deployAppServicePlan'
  params: {
    pAppServicePlanName: pAppServicePlanName
    pAppServiceName: pAppServiceName
    pAppInsightsName: pAppInsightsName
  }
}

module SQLDatabase '../SQLDatabase.bicep' = {
  name: 'SQLDatabaseDeployment'
  params: {
    pSqlServerName: pSqlServerName
    pSqlDatabaseName: pSqlDatabaseName
  }
}
