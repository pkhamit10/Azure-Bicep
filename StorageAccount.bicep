param pStorageAccountName string
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

output oStorageAccountId string = storageaccount.id
