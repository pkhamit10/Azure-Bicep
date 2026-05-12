param pStorageAccountName string
param pLocation string = resourceGroup().location

param pAppServicePlanName string
param pSKUCapacity int
param pSKUName string
param pFunctionAppName string
param startIndex int =1
param countIndex int = 5

module StorageAccount './StorageAccount.bicep' = {
  name: 'StorageAccountDeployment'
  params: {
    pStorageAccountName: pStorageAccountName
  }
}
module AppServicePlan_Linux './AppServicePlan-Linux.bicep' = {
  name: 'AppServicePlanLinuxDeployment'
  params: {
    pAppServicePlanName: pAppServicePlanName
    pSKUName: pSKUName
    pSKUCapacity: pSKUCapacity
    pLocation: pLocation
  }
}

module FunctionApp 'AzureFunctionApp.bicep' = [for i in range(startIndex, countIndex):{
  name: 'FunctionAppDeployment-${i}'
  params: {
    pLocation: pLocation
    pFunctionAppName: '${pFunctionAppName}-${i}'  
    pServerFarmId: AppServicePlan_Linux.outputs.oAppServicePlanId
    pStorageAccountName: pStorageAccountName
    pStorageAccountId: StorageAccount.outputs.oStorageAccountId
    pAppInsightsID: AppInsights[i - startIndex].outputs.oAppInsightsID
    pAppInsightsInstrumentationKey: AppInsights[i - startIndex].outputs.oAppInsightsInstrumentationKey
  }
}]

module AppInsights './modules/AppInsights.bicep' = [for i in range(startIndex, countIndex):{
  name: 'AppInsightsDeployment-${i}'
  params: {
    pAppInsightsName: '${pFunctionAppName}-${i}-appinsights'
  }
}]
