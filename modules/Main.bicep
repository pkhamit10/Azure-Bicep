module AppServicePlan '../AppServicePlan.bicep' = {
  name: 'deployAppServicePlan'
}

module SQLDatabase '../SQLDatabase.bicep' = {
  name: 'SQLDatabaseDeployment'
}
