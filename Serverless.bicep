param pStorageAccountName string
param pLocation string = resourceGroup().location

module StorageAccount './StorageAccount.bicep' = {
  name: 'StorageAccountDeployment'
  params: {
    pStorageAccountName: pStorageAccountName
  }
}
