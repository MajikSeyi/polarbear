targetScope = 'subscription'


@description('The location for resources in the UK South region.')
param ukslocation string 

@description('The environment name.')
param env string

@description('Array of address prefixes for the RSR core virtual network.')
param corevnetaddressPrefixes array


@description('The IP address for the GHA runner subnet.')
param ghactionrunnersubnet string

@description('The next hop IP address.')
param nextHopIp string

@description('The resource group for core virtual networking.')
param rgvirtualnetworking string 

@description('The resource group for RSR Github Private runners.')
param rg_ghrunner string 

@description('The resource group for shared monitoring.')
param rg_shared_monitoring string 

@description('The subscription for shared monitoring.')
param sharedmonitorsubscription string 


// Hub VNET reference
resource vnettohub 'Microsoft.Network/virtualNetworks@2022-07-01' existing = {
  name: 'hub-01-uksouth-vnet'
  scope: resourceGroup('906cdd9d-2a85-4379-a090-be4cb5da3744','network01-sharedservices-uksouth-rg')
}

// rg-virtual-networking
module rgvirtualnetwork '../../modules/Resources/resourceGroups/rg.bicep'  = {
  name: '${uniqueString(deployment().name)}-vnet-rg'
  params: {
    name: rgvirtualnetworking
    location: ukslocation
  }
}

// rg-github-private-runners
module rg_ghprivaterunner '../../modules/Resources/resourceGroups/rg.bicep'  = {
  name: '${uniqueString(deployment().name)}-runners-vnet-rg'
  params: {
    name: rg_ghrunner
    location: ukslocation
  }
}


//LAW
module law '../../Shared-Services/Shared-Monitoring/shared-monitoring.bicep' = {
  name: 'lawop${env}${uniqueString(deployment().name)}-001'
  params: {
    sharedmonitorsubscription: sharedmonitorsubscription
    sharedenv: env
    rg_shared_monitoring: rg_shared_monitoring 
    ukslocation: ukslocation
  }
}

// Default Route to Hub
module routetohub '../../modules/Networking/routeTables/routetable.bicep' = {
  name: '${uniqueString(deployment().name)}-rsr-mgt-default'
  scope: resourceGroup(rgvirtualnetworking)
  params: {
    location: ukslocation
    name: 'route-default-rsr-management-hub-firewall'
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'defaultroute-${env}-internet-traffic-to-hub-firewall'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopIpAddress: nextHopIp
          nextHopType: 'VirtualAppliance'
        }
      }
    ]
  }
  dependsOn: [rgvirtualnetwork] 
} 


// Create Core Virtual Network
module rsrcorevnet '../../modules/Networking/virtualNetworks/vnet.bicep'= {
  name: '${uniqueString(deployment().name, '${env}')}-vnet'
  scope: resourceGroup(rgvirtualnetworking)
  params: {
    diagnosticWorkspaceId: law.outputs.lawop 
    diagnosticLogsRetentionInDays: 0
    name: 'vnet-rsr-management-${ukslocation}'
    location: ukslocation
    roleAssignments: []
    addressPrefixes: corevnetaddressPrefixes
    subnets: [
      {
        name: 'GithubActionRunnersSubnet'
        addressPrefix: ghactionrunnersubnet
        routeTableId: routetohub.outputs.resourceId
        delegations: [
          {
            name: 'GitHub.Network/networkSettings'
            properties: {
              serviceName: 'GitHub.Network/networkSettings'
            }
          }
        ]
      }
    ]
    peerings: [ 
      {
        name: 'peering-to-${vnettohub.name}'
        allowVirtualNetworkAccess: true
        allowForwardedTraffic: true
        allowGatewayTransit: false
        useRemoteGateways: true
        doNotVerifyRemoteGateways: false
        remotePeeringName: 'peering-to-vnet-rsr-management-${ukslocation}'
        remotePeeringAllowVirtualNetworkAccess: true
        remotePeeringAllowForwardedTraffic: false
        remotePeeringallowGatewayTransit: true
        remotePeeringuseRemoteGateways: false
        remotePeeringdoNotVerifyRemoteGateways: false
        remotePeeringEnabled: true
        remoteVirtualNetworkId: vnettohub.id
      }
    ]
    
  }
  dependsOn: [rgvirtualnetwork] 
}



// //Github.Network  networkSetting Hidden Resource
// module ghnetworksettings 'networksettings.bicep' = {
//   name: '${uniqueString(deployment().name)}-gh-network-setting'
//   scope:  resourceGroup(rg_rsrghrunner)
//   params:{
//     ghnetworksettingname:'ns-github'
//     subnetId: rsrcorevnet.outputs.subnetResourceIds[0]
//   }
// }
