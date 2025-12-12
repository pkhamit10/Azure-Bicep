param pAppInsightsName string

 // Application Insights Resource
resource azbicepappinsights1 'Microsoft.Insights/components@2020-02-02' = {
  name: pAppInsightsName
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

output oAppInsightsInstrumentationKey string = azbicepappinsights1.properties.InstrumentationKey
