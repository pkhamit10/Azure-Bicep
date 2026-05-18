param pAppInsightsName string
param pLocation string = resourceGroup().location

 // Application Insights Resource
resource azbicepappinsights1 'Microsoft.Insights/components@2020-02-02' = {
  name: pAppInsightsName
  location: pLocation
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

output oAppInsightsInstrumentationKey string = azbicepappinsights1.properties.InstrumentationKey
output oAppInsightsID string = azbicepappinsights1.id
