targetScope = 'subscription'
//// Param ////

@description('The location for resources in the UK South region.')
param ukslocation string 

@description('The environment name.')
param env string

@description('The shared environment name.')
param envshared string 

@description('Array of address prefixes for the virtual network.')
param vnetaddressPrefixes array

@description('The IP address for the runtime subnet.')
param IPRuntimeSubnet string

@description('The IP address for the applications subnet.')
param IPApplicationsSubnet string

@description('The IP address for the Private Link subnet.')
param IPPrivateLinkSubnet string

@description('The IP address for the Private Endpoints subnet.')
param IPPrivateEndpointsSubnet string

@description('The IP address for the App Services subnet.')
param IPAppServicesSubnet string

@description('The next hop IP address.')
param nextHopIp string

@description('The resource group for virtual networking.')
param rgvirtualnetworking string 

@description('The resource group for private endpoints.')
param rgprivateendpoints string 

@description('The resource group for Spring applications.')
param rg_springapp string 

@description('The resource group for SQL Server.')
param rg_sqlserver string 

@description('The resource group for shared monitoring.')
param rg_shared_monitoring string 

@description('The resource group for shared container registries.')
param rg_shared_containerregistries string 

@description('The resource group for document storage.')
param rg_documentstorage string 

@description('The resource group for automation.')
param rgautomation string

@description('The resource group for Directus storage.')
param rg_directusstorage string 

@description('The resource group for Redis Cache.')
param rg_rediscache string 

@description('The resource group for malware scanning.')
param rg_malwarescanning string 

@description('Array of group IDs for Key Vault.')
param kvgroupIds array

@description('Array of group IDs for Configuration Stores.')
param azconfiggroupIds array 

@description('Array of group IDs for SQL Server.')
param sqlgroupIds array

@description('Array of group IDs for Blob storage.')
param blobgroupIds array 

@description('Array of group IDs for File storage.')
param filegroupIds array 

@description('Array of group IDs for Queue storage.')
param queuegroupIds array 

@description('Array of group IDs for Webhooks.')
param automategroupIds array

@description('Array of group IDs for Container Registries.')
param containerreggroupIds array 

@description('Array of group IDs for Redis Cache.')
param rediscachegroupIds array 

@description('The name for the virtual network.')
param vnetappname string 

@description('Private DNS for Azure App Configuration.')
param privatednsappconfig string 

@description('Private DNS for Azure Microservices.')
param privatednsmicro string 

@description('Private DNS for Azure Vault Core.')
param privatednsvaultcore string 

@description('Private DNS for Azure Database.')
param privatednsdatabase string 

@description('Private DNS for Azure Blob Core.')
param privatednsblobcore string 

@description('Private DNS for Azure File Core.')
param privatednsfilecore string 

@description('Private DNS for Azure Queue Core.')
param privatednsqueuecore string

@description('Private DNS for Azure Automation.')
param privateautomation string 

@description('Private DNS for Azure Container Registry.')
param privatecontainerregistry string 

@description('Private DNS for Azure Redis Cache.')
param privaterediscache string

@description('Private DNS for Azure Websites.')
param privateazurewebsites string

@description('The subscription for shared monitoring.')
param sharedmonitorsubscription string 


//// Dependancy////
module law '../../Shared-Services/Shared-Monitoring/shared-monitoring.bicep' = {
  name: 'lawop${env}${uniqueString(deployment().name)}-01'
  params: {
    sharedmonitorsubscription: sharedmonitorsubscription
    sharedenv: envshared
    rg_shared_monitoring: rg_shared_monitoring 
    // rg_springapp: rg_springapp
    ukslocation: ukslocation
  }
}



//// Routing Table ////

// Default Route to Hub
module defaulttohub '../../modules/Networking/routeTables/routetable.bicep' = {
  name: '${uniqueString(deployment().name)}-test-default'
  params: {
    location: ukslocation
    name: 'route-default-polaris-${env}-hub-firewall'
    disableBgpRoutePropagation: false
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
  scope: az.resourceGroup(rgvirtualnetworking)
} 


// Spring App Runtime Route Table
module springaruntimert '../../modules/Networking/routeTables/main.bicep' = {
  name: '${uniqueString(deployment().name)}-test-runtime'
  params: {
    location: ukslocation
    name: 'route-springruntime-polaris-${env}-hub-firewall'
    roleAssignments: [
      {
        principalId: 'ac12886c-ad23-4b83-8099-54b5ea5713d6'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Owner'
      }
    ]
    routes: [
      {
        name: 'runtimeroute-${env}-internet-traffic-to-hub-firewall'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopIpAddress: nextHopIp
          nextHopType: 'VirtualAppliance'
        }
      }
    ]
  }
  scope: az.resourceGroup(rgvirtualnetworking)
} 

// Spring App Application Route Table
module springapplicationrt '../../modules/Networking/routeTables/main.bicep' = {
  name: '${uniqueString(deployment().name)}-test-application'
  params: {
    location: ukslocation
    name: 'route-springapplication-polaris-${env}-hub-firewall'
    roleAssignments: [
      {
        principalId: 'ac12886c-ad23-4b83-8099-54b5ea5713d6'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Owner'
      }
    ]
    routes: [
      {
        name: 'applicationroute-${env}-internet-traffic-to-hub-firewall'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopIpAddress: nextHopIp
          nextHopType: 'VirtualAppliance'
        }
      }
    ]
  }
  scope: az.resourceGroup(rgvirtualnetworking)
} 

//// Network Security Group ////

// testing NSG

module defaultnsg '../../modules/Networking/networkSecurityGroups/nsg.bicep' = {
  name: '${uniqueString(deployment().name)}-test'
  params: {
    location: ukslocation
    name: 'nsg-default-polaris-${env}-${ukslocation}'
    diagnosticWorkspaceId: law.outputs.lawop
    diagnosticLogsRetentionInDays: 0
    securityRules: [
      {
        name: 'Specific'
        properties: {
          access: 'Allow'
          description: '${env} specific IPs and ports'
          destinationAddressPrefix: '*'
          destinationPortRange: '8080'
          direction: 'Inbound'
          priority: 100
          protocol: '*'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
        }
      }
      {
        name: 'Ranges'
        properties: {
          access: 'Allow'
          description: '${env} Ranges'
          destinationAddressPrefixes: [
            '10.2.0.0/16'
            '10.3.0.0/16'
          ]
          destinationPortRanges: [
            '90'
            '91'
          ]
          direction: 'Inbound'
          priority: 101
          protocol: '*'
          sourceAddressPrefixes: [
            '10.0.0.0/16'
            '10.1.0.0/16'
          ]
          sourcePortRanges: [
            '80'
            '81'
          ]
        }
      }
      {
        name: 'Port_8082'
        properties: {
          access: 'Allow'
          description: 'Allow inbound access on TCP 8082'
          DestinationAddressPrefix: '*' // remove if destinationApplicationSecurityGroups needed
          destinationPortRange: '8082'
          direction: 'Inbound'
          priority: 102
          protocol: '*'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
        }
      }
    ]
  }
  scope: az.resourceGroup(rgvirtualnetworking)
}



//// VNET deployment with Subnet ////

// Hub VNET reference - Waiting on permissions
resource vnettohub 'Microsoft.Network/virtualNetworks@2022-07-01' existing = {
  name: 'hub-01-uksouth-vnet'
  scope: resourceGroup('906cdd9d-2a85-4379-a090-be4cb5da3744','network01-sharedservices-uksouth-rg')
}

// Create VNET with 4X subnets / Add Owner role to the Azure Spring Cloud Resource Provider
module appvnet '../../modules/Networking/virtualNetworks/vnet.bicep'= {
  name: '${uniqueString(deployment().name, '${env}')}-vnet'
  params: {
    diagnosticWorkspaceId: law.outputs.lawop 
    diagnosticLogsRetentionInDays: 0
    name: 'vnet-polaris-${env}-${ukslocation}'
    location: ukslocation
    roleAssignments: [
      {
        roleDefinitionIdOrName: 'Owner'
        principalType: 'ServicePrincipal'
        principalIds: [
          'ac12886c-ad23-4b83-8099-54b5ea5713d6'
        ]
      }
    ]
    addressPrefixes: vnetaddressPrefixes
    subnets: [
      {
        name: 'SpringAppsRuntimeSubnet'
        addressPrefix: IPRuntimeSubnet
        routeTableId: springaruntimert.outputs.resourceId
      }
      {
        name: 'SpringAppsApplicationsSubnet'
        addressPrefix: IPApplicationsSubnet
        routeTableId: springapplicationrt.outputs.resourceId
      }
      {
        name: 'PrivateLinkSubnet'
        addressPrefix: IPPrivateLinkSubnet
        routeTableId: defaulttohub.outputs.resourceId
        privateLinkServiceNetworkPolicies: 'disabled'

      }
      {
        name: 'PrivateEndpointsSubnet'
        addressPrefix: IPPrivateEndpointsSubnet
        routeTableId: defaulttohub.outputs.resourceId
      }
      {
        name: 'AppServicesSubnet'
        addressPrefix: IPAppServicesSubnet
        routeTableId: defaulttohub.outputs.resourceId
        delegations: [
          {
            name: 'AppServicesDel'
            properties: {
              serviceName: 'Microsoft.Web/serverFarms'
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
        remotePeeringName: 'peering-to-vnet-polaris-${env}-uksouth'
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
  scope: az.resourceGroup(rgvirtualnetworking)
}




//// Private DNS Zone ////
// privatelink.vaultcore.azure.net
module dnsvaultcore '../../modules/Networking/privateDnsZones/privatedns.bicep' = {
  name: '${uniqueString(deployment().name)}-test-vaultcore'
  params: {
    // Required parameters
    name: privatednsvaultcore
    location: 'Global'
    virtualNetworkLinks: [
      {
        registrationEnabled: false
        virtualNetworkResourceId: appvnet.outputs.resourceId 
      }
    ]
  }
 scope: resourceGroup(rg_springapp)
}

// privatelink.azconfig.io
module dnsazconfig '../../modules/Networking/privateDnsZones/privatedns.bicep' = {
  name: '${uniqueString(deployment().name)}-test-azconfig'
  params: {
    // Required parameters
    name: privatednsappconfig
    location: 'Global'
    virtualNetworkLinks: [
      {
        registrationEnabled: false
        virtualNetworkResourceId: appvnet.outputs.resourceId
      }
    ]
  }
 scope: resourceGroup(rg_springapp)
}

// private.azuremicroservices.io
module dnsmicroservice '../../modules/Networking/privateDnsZones/privatedns.bicep' = {
  name: '${uniqueString(deployment().name)}-test-micros'
  params: {
    // Required parameters
    name: privatednsmicro
    location: 'Global'
    virtualNetworkLinks: [
      {
        registrationEnabled: false
        virtualNetworkResourceId: appvnet.outputs.resourceId
      }
    ]
  }
 scope: resourceGroup(rg_springapp)
}

// privatelink.database.windows.net
module dnsdatabase '../../modules/Networking/privateDnsZones/privatedns.bicep' = {
  name: '${uniqueString(deployment().name)}-test-database'
  params: {
    // Required parameters
    name: privatednsdatabase
    location: 'Global'
    virtualNetworkLinks: [
      {
        registrationEnabled: false
        virtualNetworkResourceId: appvnet.outputs.resourceId
      }
    ]
  }
 scope: resourceGroup(rg_springapp)
}

//  privatelink.blob.core.windows.net
module dnsblobcore '../../modules/Networking/privateDnsZones/privatedns.bicep' = {
  name: '${uniqueString(deployment().name)}-test-blob'
  params: {
    // Required parameters
    name: privatednsblobcore
    location: 'Global'
    virtualNetworkLinks: [
      {
        registrationEnabled: false
        virtualNetworkResourceId: appvnet.outputs.resourceId
      }
    ]
  }
 scope: resourceGroup(rg_springapp)
}

//  privatelink.file.core.windows.net
module dnsfilecore '../../modules/Networking/privateDnsZones/privatedns.bicep' = {
  name: '${uniqueString(deployment().name)}-test-file'
  params: {
    // Required parameters
    name: privatednsfilecore
    location: 'Global'
    virtualNetworkLinks: [
      {
        registrationEnabled: false
        virtualNetworkResourceId: appvnet.outputs.resourceId
      }
    ]
  }
 scope: resourceGroup(rg_springapp)
}

//  privatelink.queue.core.windows.net
module dnsqueuecore '../../modules/Networking/privateDnsZones/privatedns.bicep' = {
  name: '${uniqueString(deployment().name)}-test-queue'
  params: {
    // Required parameters
    name: privatednsqueuecore
    location: 'Global'
    virtualNetworkLinks: [
      {
        registrationEnabled: false
        virtualNetworkResourceId: appvnet.outputs.resourceId
      }
    ]
  }
 scope: resourceGroup(rg_springapp)
}




// privatelink.azure-automation.net
module dnsautomation '../../modules/Networking/privateDnsZones/privatedns.bicep' = {
  name: '${uniqueString(deployment().name)}-test-automation'
  params: {
    // Required parameters
    name: privateautomation
    location: 'Global'
    virtualNetworkLinks: [
      {
        registrationEnabled: false
        virtualNetworkResourceId: appvnet.outputs.resourceId
      }
    ]
  }
 scope: resourceGroup(rg_springapp)
}

// privatelink.privatelink.azurecr.io
module dnscontainerreg '../../modules/Networking/privateDnsZones/privatedns.bicep' = {
  name: '${uniqueString(deployment().name)}-test-containerreg'
  params: {
    // Required parameters
    name: privatecontainerregistry
    location: 'Global'
    virtualNetworkLinks: [
      {
        registrationEnabled: false
        virtualNetworkResourceId: appvnet.outputs.resourceId
      }
    ]
  }
 scope: resourceGroup(rg_springapp)
}


// privatelink.redis.cache.windows.net
module dnsredis '../../modules/Networking/privateDnsZones/privatedns.bicep' = {
  name: '${uniqueString(deployment().name)}-test-rediscache'
  params: {
    // Required parameters
    name: privaterediscache
    location: 'Global'
    virtualNetworkLinks: [
      {
        registrationEnabled: false
        virtualNetworkResourceId: appvnet.outputs.resourceId
      }
    ]
  }
 scope: resourceGroup(rg_springapp)
}

// privatelink.azurewebsites.net
module dnsazurewebsites '../../modules/Networking/privateDnsZones/privatedns.bicep' = {
  name: '${uniqueString(deployment().name)}-test-azurewebsites'
  params: {
    // Required parameters
    name: privateazurewebsites
    location: 'Global'
    virtualNetworkLinks: [
      {
        registrationEnabled: false
        virtualNetworkResourceId: appvnet.outputs.resourceId
      }
    ]
  }
 scope: resourceGroup(rg_springapp)
}



//// Private endpoints ////

//Private endpoint App - Key Vault

resource kvname 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: 'kv-polaris-${env}-${ukslocation}'
  scope: resourceGroup(rg_springapp)
}
output kvnameresourceid string = kvname.id

resource appvnetcheck 'Microsoft.Network/virtualNetworks@2022-07-01' existing = {
  name: vnetappname 
  scope: resourceGroup(rgvirtualnetworking)
}

resource privatesubnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' existing = {
  name: 'PrivateEndpointsSubnet' 
  parent: appvnetcheck
}
output privatesub string = privatesubnet.id

module privatekvv2 '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-test-private-${env}-v2' 
  params: {
    privateDnsZoneGroup:{
      name: 'vaultcore-private-dns'
      privateDNSResourceIds: [
        dnsvaultcore.outputs.resourceId
      ]
    }
    groupIds: kvgroupIds
    location: ukslocation 
    name: 'pe-kv-polaris-${env}'  
    serviceResourceId: kvname.id
    subnetResourceId: privatesubnet.id
  }
  dependsOn: [
    privatesubnet
    
  ]
}

//Private endpoint App configuration springapp //private.azuremicroservices.io

resource appconfigdns 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: privatednsappconfig
  scope: resourceGroup(rg_springapp)
}


resource appconfigid 'Microsoft.AppConfiguration/configurationStores@2022-05-01' existing = {
  name: 'appconfig-spring-polaris-${env}-${ukslocation}'
  scope: resourceGroup(rg_springapp)
}
output appconfigid string = appconfigid.id

module privateszconfig '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-azconfig-private-${env}-v2' 
  params: {
    privateDnsZoneGroup:{
      name: 'azconfig-private-dns'
      privateDNSResourceIds: [
        dnsazconfig.outputs.resourceId
      ]
    }
    groupIds: azconfiggroupIds
    location: ukslocation 
    name: 'pe-appconfig-spring-polaris-${env}'  
    serviceResourceId: appconfigid.id //service of app config
    subnetResourceId: privatesubnet.id
  }
  dependsOn: [
    appconfigdns
    privatesubnet
    
  ]
}

// Private endpoint - SQL server
resource sqlserver 'Microsoft.Sql/servers@2022-05-01-preview' existing = {
  name: 'sql-server-spring-polaris-${env}-${ukslocation}'
  scope: resourceGroup(rg_sqlserver)
}

module privatedatabase '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-database-private-${env}-v2' 
  params: {
    privateDnsZoneGroup:{
      name: 'database-private-dns'
      privateDNSResourceIds: [
        dnsdatabase.outputs.resourceId
      ]
    }
    groupIds: sqlgroupIds
    location: ukslocation 
    name: 'pe-sql-server-spring-polaris-${env}'  
    serviceResourceId: sqlserver.id //service of app config
    subnetResourceId: privatesubnet.id
  }
}

// Private endpoint - Blob storage
resource Stgaccount 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: 'sadocstoragepolaris${env}'
  scope: resourceGroup(rg_documentstorage)
}

resource Stgdirectus 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: 'sadirectuspolaris${env}'
  scope: resourceGroup(rg_directusstorage)
}

module privateblob '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-blob-private-${env}-v2' 
  params: {
    privateDnsZoneGroup:{
      name: 'blob-private-dns'
      privateDNSResourceIds: [
        dnsblobcore.outputs.resourceId
      ]
    }
    groupIds: blobgroupIds
    location: ukslocation 
    name: 'pe-blob-sadocstoragepolaris-${env}'  
    serviceResourceId: Stgaccount.id //service of app config
    subnetResourceId: privatesubnet.id
  }
}

module stgdocqueue '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-queue-doc-private-${env}-v2' 
  params: {
    privateDnsZoneGroup:{
      name: 'queuedocuments-private-dns'
      privateDNSResourceIds: [
        dnsqueuecore.outputs.resourceId
      ]
    }
    groupIds: queuegroupIds
    location: ukslocation 
    name: 'pe-queue-sadocstoragepolaris-${env}'  
    serviceResourceId: Stgaccount.id 
    subnetResourceId: privatesubnet.id
  }
}




module privateblobdirectus '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-blobdirectus-private-${env}-v2' 
  params: {
    privateDnsZoneGroup:{
      name: 'blobdirectus-private-dns'
      privateDNSResourceIds: [
        dnsblobcore.outputs.resourceId
      ]
    }
    groupIds: blobgroupIds
    location: ukslocation 
    name: 'pe-blob-sadirectuspolaris-${env}'  
    serviceResourceId: Stgdirectus.id //service of app config
    subnetResourceId: privatesubnet.id
  }
}

// Private endpoint - Malware scanning ( Blob and queue)
resource stgmalwarescan 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: 'sauntrustedpolaris${env}'
  scope: resourceGroup(rg_malwarescanning)
}

module stgmalwarescanblob '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-blobuntrusted-private-${env}-v2' 
  params: {
    privateDnsZoneGroup:{
      name: 'blobmalware-private-dns'
      privateDNSResourceIds: [
        dnsblobcore.outputs.resourceId
      ]
    }
    groupIds: blobgroupIds
    location: ukslocation 
    name: 'pe-blob-sauntrustedpolaris-${env}'  
    serviceResourceId: stgmalwarescan.id //service of app config
    subnetResourceId: privatesubnet.id
  }
}

module stgmalwarescanqueue '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-queue-private-${env}-v2' 
  params: {
    privateDnsZoneGroup:{
      name: 'queuemalware-private-dns'
      privateDNSResourceIds: [
        dnsqueuecore.outputs.resourceId
      ]
    }
    groupIds: queuegroupIds
    location: ukslocation 
    name: 'pe-queue-sauntrustedpolaris-${env}'  
    serviceResourceId: stgmalwarescan.id 
    subnetResourceId: privatesubnet.id
  }
}

//Private endpoint - Malware Quarantine ( Blob)
resource stgmalwareQuarantine 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: 'saquarantinepolaris${env}'
  scope: resourceGroup(rg_malwarescanning)
}

module stgmalwarQuarantineblob '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-blobquarantine-private-${env}-v2' 
  params: {
    privateDnsZoneGroup:{
      name: 'blobmalware-private-dns'
      privateDNSResourceIds: [
        dnsblobcore.outputs.resourceId
      ]
    }
    groupIds: blobgroupIds
    location: ukslocation 
    name: 'pe-blob-saquarantinepolaris-${env}'  
    serviceResourceId: stgmalwareQuarantine.id //service of app config
    subnetResourceId: privatesubnet.id
  }
}

//Private endpoint - Malware Functionapp ( Blob)
resource stgmalwarefuctionapp 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: 'safunctionspolaris${env}'
  scope: resourceGroup(rg_malwarescanning)
}

module stgmalwarfuctionappblob '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-blobfuctionapp-private-${env}-v2' 
  params: {
    privateDnsZoneGroup:{
      name: 'blobfuctionapp-private-dns'
      privateDNSResourceIds: [
        dnsblobcore.outputs.resourceId
      ]
    }
    groupIds: blobgroupIds
    location: ukslocation 
    name: 'pe-blob-safuctionapppolaris-${env}'  
    serviceResourceId: stgmalwarefuctionapp.id //service of app config
    subnetResourceId: privatesubnet.id
  }
}

module privatefiledirectus '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-file-privatedirectus-${env}-v2' 
  params: {
    privateDnsZoneGroup:{
      name: 'filedirectus-private-dns'
      privateDNSResourceIds: [
        dnsfilecore.outputs.resourceId
      ]
    }
    groupIds: filegroupIds
    location: ukslocation 
    name: 'pe-file-sadirectuspolaris-${env}'  
    serviceResourceId: Stgdirectus.id //service of app config
    subnetResourceId: privatesubnet.id
  }
}

// Private endpoint - Automation account
resource automationcheck 'Microsoft.Automation/automationAccounts@2022-08-08' existing = {
  name: 'automation-polaris-${env}-${ukslocation}'
  scope: resourceGroup(rgautomation)
}

module privateautomate '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-automate-private-${env}' 
  params: {
    privateDnsZoneGroup:{
      name: 'automate-private-dns'
      privateDNSResourceIds: [
        dnsautomation.outputs.resourceId
      ]
    }
    groupIds: automategroupIds
    location: ukslocation 
    name: 'pe-automation-polaris-${env}'  
    serviceResourceId: automationcheck.id //service of app config
    subnetResourceId: privatesubnet.id
  }
}

// Private endpoint - Container Registry /
resource containerregcheck 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' existing = {
  name: 'crreed${envshared}production'
  scope: resourceGroup(sharedmonitorsubscription, rg_shared_containerregistries)
}

module privatecontainerreg '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-container-private-${env}' 
  params: {
    privateDnsZoneGroup:{
      name: 'containerreg-private-dns'
      privateDNSResourceIds: [
        dnscontainerreg.outputs.resourceId
      ]
    }
    groupIds: containerreggroupIds
    location: ukslocation 
    name: 'pe-crreedsharedproduction-polaris-${env}'  
    serviceResourceId: containerregcheck.id //service of app config
    subnetResourceId: privatesubnet.id
  }
}

// Private endpoint - redis Cache
resource redischeck 'Microsoft.Cache/redis@2022-06-01' existing = {
  name: 'redis-polaris-${env}-${ukslocation}'
  scope: resourceGroup(rg_rediscache)
}

module privateredis '../../modules/Networking/privateEndpoints/Privateendpoint.bicep' = {
  scope: resourceGroup(rgprivateendpoints) 
  name: '${uniqueString(deployment().name)}-rediscache-private-${env}' 
  params: {
    privateDnsZoneGroup:{
      name: 'rediscache-private-dns'
      privateDNSResourceIds: [
        dnsredis.outputs.resourceId
      ]
    }
    groupIds: rediscachegroupIds
    location: ukslocation 
    name: 'pe-redis-polaris-${env}'  
    serviceResourceId: redischeck.id //service of app config
    subnetResourceId: privatesubnet.id
  }
}


//// Frontdoor Deployment ////


