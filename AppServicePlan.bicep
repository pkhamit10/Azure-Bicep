resource azbicepasp1 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'azbicep_dev_fc_asp1'
  location: resourceGroup().location
  sku: {
    name: 'F1'
    tier: 'Free'
    size: 'F1'
    family: 'F'
    capacity: 1
  }
}

resource azbicepappserv1 'Microsoft.Web/sites@2021-02-01' = {
  name: 'azbicep-dev-fc-webapp1'
  location: resourceGroup().location
  properties: {
    serverFarmId: resourceId('Microsoft.Web/serverfarms', azbicepasp1.name)
  }
  dependsOn: [
    azbicepasp1
  ] 
}
