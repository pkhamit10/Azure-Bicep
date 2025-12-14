param pSqlServerName string
param pSqlDatabaseName string 
param padminLogin string 
@secure()
param padminPassword string


resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: pSqlServerName
  location: resourceGroup().location
  properties: {
    administratorLogin: padminLogin
    administratorLoginPassword: padminPassword
    version: '12.0'
  }
}

resource sqlServerFirewallRules 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  parent: sqlServer
  name: 'sqlServerFirewallRule1'
  properties: {
    startIpAddress: '4.4.4.4'
    endIpAddress: '4.4.4.4'
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  parent: sqlServer
  name: pSqlDatabaseName
  location: resourceGroup().location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 2147483648
    sku: {
      name: 'S0'
      tier: 'Standard'
      capacity: 10
    }
  }
}


