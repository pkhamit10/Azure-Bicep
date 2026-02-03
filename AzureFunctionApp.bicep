param pLocation string = resourceGroup().location
param pServerFarmId string
param pFunctionAppName string
param pStorageAccountName string 
param pStorageAccountId string

resource functionApp 'Microsoft.Web/sites@2021-02-01' = {
  name: pFunctionAppName
  location: pLocation
  kind: 'functionapp'
  properties: {
    serverFarmId: pServerFarmId
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsDashboard'
          value: 'DefaultEndpointsProtocol=https;AccountName=${pStorageAccountName};AccountKey=${listKeys(pStorageAccountId, '2022-09-01').keys[0].value}'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${pStorageAccountName};AccountKey=${listKeys(pStorageAccountId, '2022-09-01').keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${pStorageAccountName};AccountKey=${listKeys(pStorageAccountId, '2022-09-01').keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(pFunctionAppName)
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4' 
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
    }
  }
} 
