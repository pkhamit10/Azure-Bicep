param pStorageAccountName string
param pfileShareName string
param pLocation string = resourceGroup().location
resource storageaccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: pStorageAccountName
  location: pLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2022-09-01' = {
  name: '${pStorageAccountName}/default/${pfileShareName}'
  dependsOn: [
    storageaccount
  ]
}

output oStorageAccountId string = storageaccount.id

