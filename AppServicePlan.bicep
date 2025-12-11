resource azbicepasp1 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'azbicep_dev_fc_asp1'
  location: resourceGroup().location
  sku: {
    name: 'S1'
    tier: 'standard'
    size: 'S1'
    family: 'S'
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

resource azbicepwebapp1appsetting 'Microsoft.Web/sites/config@2025-03-01'  = {
  parent: azbicepappserv1
  name: 'web'
  properties: {
    appSettings: [
      {
        name: 'key1'
        value: 'value1'
      }
      {
        name: 'key2'
        value: 'value2'
      }
    ]
  }
}
 
resource azbicepappinsights1 'Microsoft.Insights/components@2020-02-02' = {
  name: 'azbicep-dev-fc-ai1'
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}
