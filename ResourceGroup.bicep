targetScope = 'subscription'

resource dev_rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'azbicep_dev_fc_rg'
  location: 'France Central'
} 

resource test_rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'azbicep_stage_fc_rg'
  location: 'France Central'
} 

resource prod_rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'azbicep_prod_fc_rg'
  location: 'France Central'
} 

