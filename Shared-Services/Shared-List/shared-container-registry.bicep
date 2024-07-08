targetScope = 'subscription' 

//// Parameters ////
param sharedenv string
param ukslocation string
param rg_shared_monitoring string // rg-shared-monitoring
param sharedmonitorsubscription string
param rg_shared_containerregistries string
param createacrtoken bool
param createdirectustoken bool




//// Dependancy////createdirectustoken
// LAW check
module law '../../Shared-Services/Shared-Monitoring/shared-monitoring.bicep' = {
  name: 'lawop${sharedenv}${uniqueString(deployment().name)}-01'
  params: {
    sharedmonitorsubscription: sharedmonitorsubscription
    sharedenv: sharedenv
    rg_shared_monitoring: rg_shared_monitoring 
    // rg_springapp: rg_springapp
    ukslocation: ukslocation
  }
}

resource lawaudit 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: 'm365azuresentinel-dw-prod-uks-la'
  scope: resourceGroup('e7fe7e3e-7874-4903-87be-422595a82d07','it-dw-sentinel-logs-production-rg' )
}

// Webapp check


resource uatwebappcheck 'Microsoft.Web/sites@2022-03-01' existing = {
  name: 'as-app-directus-polaris-uat-uksouth' 
  scope: resourceGroup('8e9001ef-d089-4768-b516-ae4be3e68dde', 'rg-directus')
}

resource prodwebappcheck 'Microsoft.Web/sites@2022-03-01' existing = {
  name: 'as-app-directus-polaris-prod-uksouth' 
  scope: resourceGroup('95ca7646-ed92-470e-9dfb-23f25093d507', 'rg-directus')
}

// Webapp check
resource tstfunctionapp 'Microsoft.Web/sites@2022-03-01' existing = {
  name: 'as-app-malwarescan-polaris-test-uksouth' 
  scope: resourceGroup('f00e932c-2dc9-4eed-83ab-28bee4d9dbb3', 'rg-malwarescanning')
}

resource uatfunctionapp 'Microsoft.Web/sites@2022-03-01' existing = {
  name: 'as-app-malwarescan-polaris-uat-uksouth' 
  scope: resourceGroup('8e9001ef-d089-4768-b516-ae4be3e68dde', 'rg-malwarescanning')
}

resource prodfunctionapp 'Microsoft.Web/sites@2022-03-01' existing = {
  name: 'as-app-malwarescan-polaris-prod-uksouth' 
  scope: resourceGroup('95ca7646-ed92-470e-9dfb-23f25093d507', 'rg-malwarescanning')
}

///// Deployment /////
module containerregistries '../../modules/Microsoft.ContainerRegistry/registries/deploy.bicep' = { 
  name: '${uniqueString(deployment().name, ukslocation)}-test-crrcom'
  scope: resourceGroup(sharedmonitorsubscription, rg_shared_containerregistries )
  params: {
    name: 'crreed${sharedenv}production'
    acrAdminUserEnabled: false
    acrSku: 'Premium'
    publicNetworkAccess: 'Enabled'
    azureADAuthenticationAsArmPolicyStatus: 'enabled'
    diagnosticLogsRetentionInDays: 7
    diagnosticWorkspaceId: lawaudit.id
    diagnosticWorkspaceIdMetric: law.outputs.lawop
    roleAssignments: [

      {
        principalIds: [
          uatwebappcheck.identity.principalId
        ]
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'AcrPull'
      }
      {
        principalIds: [
          prodwebappcheck.identity.principalId
        ]
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'AcrPull'
      }
      {
        principalIds: [
          tstfunctionapp.identity.principalId
        ]
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'AcrPull'
      }
      {
        principalIds: [
          uatfunctionapp.identity.principalId
        ]
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'AcrPull'
      }
      {
        principalIds: [
          prodfunctionapp.identity.principalId
        ]
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'AcrPull'
      }
    ]
    exportPolicyStatus: 'enabled'

    webhooks: [
      {
        name: 'webappreedrhelloworldstandard'
        serviceUri: 'https://www.contoso.com/webhook'
      }
    ]
    softDeletePolicyDays: 7
    softDeletePolicyStatus: 'disabled'
    systemAssignedIdentity: true
    trustPolicyStatus: 'enabled'

  }
}

//// Scope Mapping
module scopemap '../../modules/Microsoft.ContainerRegistry/registries/scopemaps/scopemaps.bicep' = {
  scope: resourceGroup(sharedmonitorsubscription, rg_shared_containerregistries )
  name: '${uniqueString(deployment().name, ukslocation)}-mapping'
  params: {
    scopemapname: 'storage-scanning-repository-push'
    registryName: containerregistries.outputs.name
    scopemapdescription: 'Can push to storage scanning repository of the registry'
    action: [
      'repositories/base/reedspecialistrecruitment/azure/storage/scanning/content/read'
      'repositories/base/reedspecialistrecruitment/azure/storage/scanning/content/write'
      'repositories/reedspecialistrecruitment/azure/storage/scanning/content/read'
      'repositories/reedspecialistrecruitment/azure/storage/scanning/content/write'
      'repositories/reedinpartnership/polaris/azure/storage/scanning/content/read'
      'repositories/reedinpartnership/polaris/azure/storage/scanning/content/write'
      'repositories/development/reedspecialistrecruitment/azure/storage/scanning/content/read'
      'repositories/development/reedspecialistrecruitment/azure/storage/scanning/content/write'
    ]
  }
}


module scopemapdirectus '../../modules/Microsoft.ContainerRegistry/registries/scopemaps/scopemaps.bicep' = {
  scope: resourceGroup(sharedmonitorsubscription, rg_shared_containerregistries )
  name: '${uniqueString(deployment().name, ukslocation)}-direcus'
  params: {
    scopemapname: 'directus-repository-push'
    registryName: containerregistries.outputs.name
    scopemapdescription: 'Can push to storage scanning repository of the registry'
    action: [
      'repositories/reedinpartnership/polaris/directus/content/read'
      'repositories/reedinpartnership/polaris/directus/content/write'
    ]
  }
}



//// Token creation
module token '../../modules/Microsoft.ContainerRegistry/registries/token/acrtoken.bicep' = if (createacrtoken == true) {
  scope: resourceGroup(sharedmonitorsubscription, rg_shared_containerregistries )
  name: '${uniqueString(deployment().name, ukslocation)}-tokendirectus'
  params: {
    tokenname: 'github-storage-scanning-user'
    registryName: containerregistries.outputs.name 
    scopemapName: scopemap.outputs.resourceId  
  }
}


module tokendirecus '../../modules/Microsoft.ContainerRegistry/registries/token/acrtoken.bicep' = if (createdirectustoken == true) {
  scope: resourceGroup(sharedmonitorsubscription, rg_shared_containerregistries )
  name: '${uniqueString(deployment().name, ukslocation)}-tokendirectus'
  params: {
    tokenname: 'github-directus-user'
    registryName: containerregistries.outputs.name 
    scopemapName: scopemapdirectus.outputs.resourceId 
  }
}




output springtoarray array = array(tstfunctionapp.properties.possibleOutboundIpAddresses)

