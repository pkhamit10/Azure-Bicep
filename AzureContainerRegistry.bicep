param pACRName string = 'pkacr001'
param pACRLocation string = resourceGroup().location
param pACRSku string = 'Basic'

resource acr 'Microsoft.ContainerRegistry/registries@2021-09-01'= {
  name: pACRName
  location: pACRLocation
  sku: {
    name: pACRSku
  }
  properties: {
    adminUserEnabled: true // Enable admin user for ACR and container registery enables the passwords
  }
}
