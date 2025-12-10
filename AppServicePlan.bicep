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

resource azbicepasp2 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'azbicep_dev_fc_linux_asp1'
  kind: 'linux'
  location: resourceGroup().location
  properties: {
    reserved: true
  }
  sku: {
    name: 'F1'
    tier: 'Free'
    size: 'F1'
    family: 'F'
    capacity: 1
  }
}
