param pAppServicePlanName string
param pLocation string = resourceGroup().location
param pSKUName string
param pSKUCapacity int

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: pAppServicePlanName
  location: pLocation
  kind: 'Linux'
  properties: {
    reserved: true
  }
  sku: {
    name: pSKUName
    capacity: pSKUCapacity
  }
}

output oAppServicePlanId string = appServicePlan.id
