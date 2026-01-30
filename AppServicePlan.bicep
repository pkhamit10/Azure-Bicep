param pAppServiceName string 
param pAppServicePlanName string
param pInstrumentkey string
@description('''
Please provide a valid SKU Name. The allowed values are: 
- Free, 
- Shared, 
- Basic, 
- Standard, 
- Premium
''')
@allowed([
  'Free'
  'Shared'
  'Basic'
  'Standard'
  'Premium'
])
param pSKUName string 
//  AppServicePlan  Resource
resource azbicepasp1 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: pAppServicePlanName
  location: resourceGroup().location
  sku: {
    name: pSKUName
    capacity: 1
  }
}

 // Web App Service
resource azbicepappserv1 'Microsoft.Web/sites@2021-02-01' = {
  name: pAppServiceName
  location: resourceGroup().location
  properties: {
    serverFarmId: resourceId('Microsoft.Web/serverfarms', azbicepasp1.name)
  }
  dependsOn: [
    azbicepasp1
  ] 
}  

// Web App Settings
 resource azbicepwebapp1appsetting 'Microsoft.Web/sites/config@2025-03-01'  = {
  parent: azbicepappserv1
  name: 'web'
  properties: {
    appSettings: [
      {
        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
        value: pInstrumentkey
      }
      {
        name: 'key2'
        value: 'value2'
      }
    ]
  }
} 
 
