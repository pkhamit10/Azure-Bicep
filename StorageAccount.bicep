param pStorageAccountName string
resource storageaccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: pStorageAccountName
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

output oStorageAccountId string = storageaccount.id
