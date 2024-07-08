targetScope = 'subscription'


// Param ////
param sharedmonitorsubscription string
param rg_shared_b2c string
param ukslocation string
param rg_shared_monitoring string
param rg_shared_containerregistries string

//// Create Shared Monitor RG

// rg-shared-monitoring
module rgsharedmonitoring '../../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-monitoring-rg'
  scope: subscription(sharedmonitorsubscription)
  params: {
    name: rg_shared_monitoring
    location: ukslocation
  }
}

// rg-shared-containerregistries
module rgsharedcontainerregistries '../../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-containerreg-rg'
  scope: subscription(sharedmonitorsubscription)
  params: {
    name: rg_shared_containerregistries
    location: ukslocation
  }
}


