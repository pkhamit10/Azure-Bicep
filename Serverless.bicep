param pStorageAccountName string
param pLocation string = resourceGroup().location

param pAppServicePlanName string
param pSKUCapacity int
param pSKUName string
param pFunctionAppName string

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

module FunctionApp 'AzureFunctionApp.bicep' = {
  name: 'FunctionAppDeployment'
  params: {
    pLocation: pLocation
    pFunctionAppName: pFunctionAppName
    pServerFarmId: AppServicePlan_Linux.outputs.oAppServicePlanId
    pStorageAccountName: pStorageAccountName
    pStorageAccountId: StorageAccount.outputs.oStorageAccountId
  }
}
