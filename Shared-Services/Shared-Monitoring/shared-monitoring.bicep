targetScope = 'subscription'

param sharedenv string //
param ukslocation string
param rg_shared_monitoring string // rg-shared-monitoring
param sharedmonitorsubscription string



//// LAW x2 - Operational & Security Workspaces ////

module lawoperational '../../modules/Microsoft.OperationalInsights/workspaces/deploy.bicep' = {
  scope: resourceGroup(sharedmonitorsubscription, rg_shared_monitoring)
  name: 'lawop${sharedenv}${uniqueString(deployment().name)}'
  params: {
    name: 'law-${sharedenv}-operational-${ukslocation}'
    location: ukslocation
    useResourcePermissions: true
  }
}

@description('ResourceID for LAW operations')
output lawop string = lawoperational.outputs.resourceId






