targetScope =  'subscription'

param tstenv string = 'test'
param envshared string = 'shared'
param rg_shared_monitoring string = 'rg-shared-monitoring'
param ukslocation string = 'uksouth'

param sharedmonitorsubscription string = '3592b1b4-dca4-42c2-95dc-bf0902211479'
param rg_virtual_network string = 'rg-virtual-networking'
param sharedgateway string = 'e22eb6a5-6f38-4574-9b84-1c1dbe1c8b97'

param vnetaddressPrefixes array = [ 
  '172.16.8.0/22'
]
// param PolarisVnetDataGWSubnet string

//// Dependancys //// 


// LAW
module law '../../Shared-Services/Shared-Monitoring/shared-monitoring.bicep'  = {
  name: 'lawop${tstenv}${uniqueString(deployment().name)}-001'
  params: {
    sharedmonitorsubscription: sharedmonitorsubscription
    sharedenv: envshared
    rg_shared_monitoring: rg_shared_monitoring 
    ukslocation: ukslocation
  }
}

// resource lawaudit 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
//   name: 'm365azuresentinel-dw-prod-uks-la'
//   scope: resourceGroup('e7fe7e3e-7874-4903-87be-422595a82d07','it-dw-sentinel-logs-production-rg' )
// }

// Deployed into new Subscription
// Front Door premium

// module afddeployment '../../modules/Networking/frontDoors/frontdoorv2.bicep' = {
//   scope: resourceGroup('rg-frontdoor')
//   name: '${uniqueString(deployment().name)}-test-${env}'
//   params: {  
//     location: ukslocation
//   }
// }

// Resource Group - rg-virtual-networking
module virtualnetworkrg '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-vnet-shared-rg'
  scope: subscription(sharedgateway)
  params: {
    name: rg_virtual_network
    location: ukslocation
  }
}


// Create shared VNET 

module vnet '../../modules/Networking/virtualNetworks/vnet.bicep' = {
  name: '${uniqueString(deployment().name, '${ukslocation}')}-vnet'
  scope: resourceGroup(rg_virtual_network)
  params: {
    diagnosticWorkspaceId: law.outputs.lawop
    diagnosticLogsRetentionInDays: 0
    name: 'vnet-shared-gateways-${ukslocation}'
    location: ukslocation
    addressPrefixes: vnetaddressPrefixes
  }
}

module Subnet '../../modules/Networking/virtualNetworks/subnets/subnet.bicep' = {
  name: '${uniqueString(deployment().name, '${ukslocation}')}-subnet'
  scope: resourceGroup(rg_virtual_network)
  params: {
    addressPrefix: '172.16.8.0/27'
    name: 'PolarisVnetDataGWSubnet1'
    routeTableId: defaultroutetable.outputs.resourceId
    networkSecurityGroupId: defaultnsg.outputs.resourceId
    virtualNetworkName: vnet.outputs.name
    delegations: [
      {
        name: 'Microsoft.PowerPlatform.vnetaccesslinks'
        properties: {
          serviceName: 'Microsoft.PowerPlatform/vnetaccesslinks'
        }
      }
    ] 
  }
}



//  Route Table ////

// Default Route to Hub
module defaultroutetable '../../modules/Networking/routeTables/routetable.bicep' = {
  name: '${uniqueString(deployment().name)}-routetable-vnet'
  scope: resourceGroup(rg_virtual_network)
  params: {
    location: ukslocation
    name: 'route-default-shared-gateways-hub-firewall'
    routes: [
      {
        name: 'defaultroute-shared-gateways-internet-traffic-to-hub-firewall'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopIpAddress: '172.16.0.68'
          nextHopType: 'VirtualAppliance'
        }
      }
    ]
  }
} 


// //// Network security group

module defaultnsg '../../modules/Networking/networkSecurityGroups/nsg.bicep' = {
  name: '${uniqueString(deployment().name)}-nsg-vnet'
  scope: resourceGroup(rg_virtual_network)
  params: {
    location: ukslocation
    name: 'nsg-default-shared-gateways-${ukslocation}'
    // diagnosticWorkspaceId: law.outputs.lawop
    // securityRules: [
    //   {
    //     name: 'Specific'
    //     properties: {
    //       access: 'Allow'
    //       description: '${env} specific IPs and ports'
    //       destinationAddressPrefix: '*'
    //       destinationPortRange: '8080'
    //       direction: 'Inbound'
    //       priority: 100
    //       protocol: '*'
    //       sourceAddressPrefix: '*'
    //       sourcePortRange: '*'
    //     }
    //   }
    //   {
    //     name: 'Ranges'
    //     properties: {
    //       access: 'Allow'
    //       description: '${env} Ranges'
    //       destinationAddressPrefixes: [
    //         '10.2.0.0/16'
    //         '10.3.0.0/16'
    //       ]
    //       destinationPortRanges: [
    //         '90'
    //         '91'
    //       ]
    //       direction: 'Inbound'
    //       priority: 101
    //       protocol: '*'
    //       sourceAddressPrefixes: [
    //         '10.0.0.0/16'
    //         '10.1.0.0/16'
    //       ]
    //       sourcePortRanges: [
    //         '80'
    //         '81'
    //       ]
    //     }
    //   }
    //   {
    //     name: 'Port_8082'
    //     properties: {
    //       access: 'Allow'
    //       description: 'Allow inbound access on TCP 8082'
    //       // destinationApplicationSecurityGroups: [
    //       //   {
    //       //     id: '<id>'
    //       //   }
    //       // ]
    //       DestinationAddressPrefix: '*' // remove if destinationApplicationSecurityGroups needed
    //       destinationPortRange: '8082'
    //       direction: 'Inbound'
    //       priority: 102
    //       protocol: '*'
    //       sourceAddressPrefix: '*'
    //       sourcePortRange: '*'
    //     }
    //   }
    // ]
  }
}
