targetScope= 'subscription'

//// Paramaters ////
@description('The location for resources in the UK South region.')
param ukslocation string

@description('The shared environment name.')
param envshared string

@description('Resource group for Spring applications.')
param rg_springapps string = 'rg-springapps'

@description('The subscription for shared monitoring.')
param sharedmonitorsubscription string

@description('The environment name.')
param env string

@description('The resource group for the Data Factory.')
param rg_datafactory string

@description('The resource group for the shared monitoring.')
param rg_shared_monitoring string

@description('The resource group for the shared monitoring.')
param rg_virtual_networking string = 'rg-virtual-networking'

@description('Private DNS for Azure Vault Core.')
param privatednsvaultcore string 

@description('Subnet resource id for azuksouth-xp')
param snetazuksouthxp string 

@description('Subnet resource id for azuksouth-xp')
param snetazuksouthgs string 

@description('Indicates whether to run ADF .')
param adfresourceExists bool 

@description('Indicates whether a key vault is present.')
param kvresourceExists bool 

@description('Required - DataFactory CoreCount')
param corecount int 

@description('Required - DataFactory ttltype')
param ttltype int 

@description('Required - DataFactory ttlpipeline')
param ttlpipeline int

@description('Required - DataFactory pipelinenode') 
param pipelinenode int

@description('Required - DataFactory externalnode')
param externalnode int 

//LAW
module law '../../Shared-Services/Shared-Monitoring/shared-monitoring.bicep' = {
  name: 'lawop${env}${uniqueString(deployment().name)}-001'
  params: {
    sharedmonitorsubscription: sharedmonitorsubscription
    sharedenv: envshared
    rg_shared_monitoring: rg_shared_monitoring 
    ukslocation: ukslocation
  }
}

// Existing checks
resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01' existing = {
  name: 'vnet-polaris-${env}-${ukslocation}'
  scope: resourceGroup(rg_virtual_networking)
}

resource subnetprivatelink 'Microsoft.Network/virtualnetworks/subnets@2015-06-15' existing = {
  name: 'PrivateEndpointsSubnet'
  parent: vnet
}


resource privatedns  'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: privatednsvaultcore
  scope: resourceGroup(rg_springapps)
}



module factory '../../modules/data-factory/factory/main.bicep' = if (adfresourceExists == true) {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-dffcom'
  scope: resourceGroup(rg_datafactory)
  params: {
    // Required parameters
    name: 'adf-polaris-${env}-${ukslocation}'
    location: ukslocation
    systemAssignedIdentity: true
    diagnosticWorkspaceId: law.outputs.lawop
    integrationRuntimes: [
      {
        managedVirtualNetworkName: 'default'
        name: 'AutoResolveIntegrationRuntime'
        type: 'Managed'
        typeProperties: {
          computeProperties: {
            location: 'AutoResolve'
          }
        }
      }
      {
        managedVirtualNetworkName: 'default'
        name: 'PipelineExecutionRuntime'
        type: 'Managed'
        typeProperties: {
          computeProperties: {  
            location: 'UK South'
            dataFlowProperties: {
              computeType: 'General'
              coreCount: corecount
              timeToLive: ttltype
              cleanup: false
            }
            pipelineExternalComputeScaleProperties: {
              timeToLive: ttlpipeline
              numberOfPipelineNodes: pipelinenode
              numberOfExternalNodes: externalnode
            }
          }
        }
      }
    ]
    managedVirtualNetworkName: 'default'
  }
}


// vnet resource 


module kvfactory '../../modules/Security/Microsoft.KeyVault/vaults/deploy.bicep' = if (kvresourceExists == true) { 
  scope: resourceGroup(rg_datafactory) 
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-kv12' 
  params: {
    name: 'kv-adf-${env}-${ukslocation}'
    publicNetworkAccess: 'Enabled'
    enableRbacAuthorization: true
     networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      ipRules:[
        {
          value: '195.138.205.241/32'
        }

      ] 
     }
    privateEndpoints: [
      {
        privateDnsZoneGroup: {
          privateDNSResourceIds: [
            privatedns.id
          ]
        }
        service: 'vault'
        subnetResourceId: subnetprivatelink.id
      }
    ]

  }
}



//ADF STAGING SA


module stgadfstaging '../../modules/Storage/storageAccounts/stg.bicep' = {
  scope: resourceGroup(rg_datafactory)
  name: 'stgdeploy${env}${uniqueString(deployment().name)}-adfstagingsa' 
  params: {
    name: 'saadfstaging${env}' 
    storageAccountSku: 'Standard_ZRS' 
    diagnosticWorkspaceId: law.outputs.lawop
    networkAcls: {
      resourceAccessRules: []
      bypass: 'AzureServices'
      virtualNetworkRules: [
        {
             action: 'Allow'
             id: snetazuksouthgs
             
        }
        {
             action: 'Allow'
             id: snetazuksouthxp
  
        }
      ]
      ipRules: [
        {
          value: '195.138.205.241'
          action: 'Allow'
        }
      ]
      defaultAction: 'Deny'
    }
    blobServices: {
      containers: [
        {
          name: 'snowflakestaging'
          roleAssignments: [
            {
              principalIds: [
                factory.outputs.systemAssignedPrincipalId
              ]
              principalType: 'ServicePrincipal'
              roleDefinitionIdOrName: 'Storage Blob Data Contributor'
            }
          ]
        }
        {
          name: 'snowflakelogging'
          roleAssignments: [
            {
              principalIds: [
                factory.outputs.systemAssignedPrincipalId
              ]
              principalType: 'ServicePrincipal'
              roleDefinitionIdOrName: 'Storage Blob Data Contributor'
            }
          ]
        }
      
      ]
    }
    privateEndpoints: [
      {
        privateDnsZoneGroup: {
          privateDNSResourceIds: [
            privatedns.id
          ]
        }
        service: 'blob'
        subnetResourceId: subnetprivatelink.id
      }
    ]
  }
}

