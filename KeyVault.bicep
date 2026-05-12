param location string = resourceGroup().location
param keyVaultName string = 'az-bicep-keyvaultpk1'

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: '907ba8dc-6c1f-4fa1-a337-e774f7f1d595'
        permissions: {
          keys: [
            'get'
            'list'
          ]
          secrets: [
            'list'
            'get'
            'set'
          ]
        }
      }
    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

resource Key 'Microsoft.KeyVault/vaults/keys@2025-05-01' = {
  name: 'pkKey1'
  parent: keyVault
  properties: {
    keySize: '2048'
    kty: 'RSA'
    curveName: 'P-256'
  }
}

resource Secret 'Microsoft.KeyVault/vaults/secrets@2025-05-01' = {
  name: 'pkSecret1'
  parent: keyVault
  properties: {
    value: 'mySecretValue'
  } 
} 
