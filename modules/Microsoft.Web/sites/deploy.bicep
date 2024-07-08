// ================ //
// Parameters       //
// ================ //
// General
@description('Required. Name of the site.')
param name string

@description('Optional. Location for all Resources.')
param location string = resourceGroup().location

@description('Required. Type of site to deploy.')
@allowed([
  'functionapp' // function app windows os
  'functionapp,linux' // function app linux os
  'functionapp,workflowapp' // logic app workflow
  'functionapp,workflowapp,linux' // logic app docker container
  'app' // normal web app
])
param kind string

@description('Required. The resource ID of the app service plan to use for the site.')
param serverFarmResourceId string

@description('Optional. Configures a site to accept only HTTPS requests. Issues redirect for HTTP requests.')
param httpsOnly bool = true

@description('Optional. If client affinity is enabled.')
param clientAffinityEnabled bool = true

@description('Optional. The resource ID of the app service environment to use for this resource.')
param appServiceEnvironmentId string = ''

@description('Optional. Enables system assigned managed identity on the resource.')
param systemAssignedIdentity bool = true

@description('Optional. The ID(s) to assign to the resource.')
param userAssignedIdentities object = {}

@description('Optional. The resource ID of the assigned identity to be used to access a key vault with.')
param keyVaultAccessIdentityResourceId string = ''

@description('Optional. Checks if Customer provided storage account is required.')
param storageAccountRequired bool = false

@description('Optional. Azure Resource Manager ID of the Virtual network and subnet to be joined by Regional VNET Integration. This must be of the form /subscriptions/{subscriptionName}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}.')
param virtualNetworkSubnetId string = ''

// Site Config
@description('Optional. The site config object.')
param siteConfig object = {}

@description('Optional. Required if app of kind functionapp. Resource ID of the storage account to manage triggers and logging function executions.')
param storageAccountId string = ''

@description('Optional. Resource ID of the app insight to leverage for this resource.')
param appInsightId string = ''

@description('Optional. The app settings-value pairs except for AzureWebJobsStorage, AzureWebJobsDashboard, APPINSIGHTS_INSTRUMENTATIONKEY and APPLICATIONINSIGHTS_CONNECTION_STRING.')
param appSettingsKeyValuePairs object = {}

@description('Optional. The app settings-value pairs except for AzureWebJobsStorage, AzureWebJobsDashboard, APPINSIGHTS_INSTRUMENTATIONKEY and APPLICATIONINSIGHTS_CONNECTION_STRING.')
param appSettingsKeyValuePairsfunction object = {}

@description('Optional. The auth settings V2 configuration.')
param authSettingV2Configuration object = {}

param vnetImagePull bool 

// Lock
@allowed([
  ''
  'CanNotDelete'
  'ReadOnly'
])
@description('Optional. Specify the type of lock.')
param lock string = ''

// Private Endpoints
@description('Optional. Configuration details for private endpoints. For security reasons, it is recommended to use private endpoints whenever possible.')
param privateEndpoints array = []

// List of slots
@description('Optional. Configuration for deployment slots for an app.')
param slots array = []

// Tags
@description('Optional. Tags of the resource.')
param tags object = {}

// PID
@description('Optional. Enable telemetry via a Globally Unique Identifier (GUID).')
param enableDefaultTelemetry bool = true

// Role Assignments
@description('Optional. Array of role assignment objects that contain the \'roleDefinitionIdOrName\' and \'principalId\' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'.')
param roleAssignments array = []

// Diagnostic Settings
@description('Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.')
@minValue(0)
@maxValue(365)
param diagnosticLogsRetentionInDays int = 0

@description('Optional. Resource ID of the diagnostic storage account.')
param diagnosticStorageAccountId string = ''

param stgaccess string = ''

param stgdirectusname  string = ''

param stgfunctionname string = ''

@description('Optional. Resource ID of log analytics workspace.')
param diagnosticWorkspaceId string = ''

param diagnosticWorkspaceIdaudit string = ''

param diagnosticWorkspaceIdauditapp string = ''

@description('Optional. The managed identity definition for this resource.')
param managedIdentities managedIdentitiesType


@description('Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.')
param diagnosticEventHubAuthorizationRuleId string = ''

@description('Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.')
param diagnosticEventHubName string = ''

@description('Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource.')
@allowed([
  'AppServiceConsoleLogs'
  'AppServiceAppLogs'
  'AppServicePlatformLogs'
  'FunctionAppLogs'
])
param diagnosticLogCategoriesToEnable array = kind == 'functionapp,linux' ? [
  'FunctionAppLogs'
] : [
  'AppServiceConsoleLogs'
  'AppServiceAppLogs'
  'AppServicePlatformLogs'
]


@description('Optional. The name of metrics that will be streamed.')
@allowed([
  'AllMetrics'
])
param diagnosticMetricsToEnable array = [
  'AllMetrics'
]

@description('Optional. The name of the diagnostic setting, if deployed.')
param diagnosticSettingsName string = '${name}-diagnosticSettings'

@description('Optional. The name of the diagnostic setting, if deployed.')
param diagnosticSettingsNameaudit string = '${name}-diagnosticSettings-audit'

@description('Optional. The name of the diagnostic setting, if deployed.')
param diagnosticSettingsNameauditapp string = '${name}-diagnosticSettings-audit-app'

// =========== //
// Variables   //
// =========== //
var diagnosticsLogsSpecified = [for category in filter(diagnosticLogCategoriesToEnable, item => item != ''): {
  category: category
  enabled: true
  retentionPolicy: {
    enabled: true
    days: diagnosticLogsRetentionInDays
  }
}]

var diagnosticsLogs = contains(diagnosticLogCategoriesToEnable, '') ? [
  {
    categoryGroup: diagnosticLogCategoriesToEnable
    enabled: true
    retentionPolicy: {
      enabled: true
      days: diagnosticLogsRetentionInDays
    }
  }
] : diagnosticsLogsSpecified



var diagnosticsMetrics = [for metric in diagnosticMetricsToEnable: {
  category: metric
  timeGrain: null
  enabled: true
  retentionPolicy: {
    enabled: true
    days: diagnosticLogsRetentionInDays
  }
}]

var formattedUserAssignedIdentities = reduce(map((managedIdentities.?userAssignedResourceIds ?? []), (id) => { '${id}': {} }), {}, (cur, next) => union(cur, next)) // Converts the flat array to an object like { '${id1}': {}, '${id2}': {} }

var identity = !empty(managedIdentities) ? {
  type: (managedIdentities.?systemAssigned ?? false) ? (!empty(managedIdentities.?userAssignedResourceIds ?? {}) ? 'SystemAssigned,UserAssigned' : 'SystemAssigned') : (!empty(managedIdentities.?userAssignedResourceIds ?? {}) ? 'UserAssigned' : null)
  userAssignedIdentities: !empty(formattedUserAssignedIdentities) ? formattedUserAssignedIdentities : null
} : null

var enableReferencedModulesTelemetry = false

// =========== //
// Deployments //
// =========== //
resource defaultTelemetry 'Microsoft.Resources/deployments@2021-04-01' = if (enableDefaultTelemetry) {
  name: 'pid-47ed15a6-730a-4827-bcb4-0fd963ffbd82-${uniqueString(deployment().name, location)}'
  properties: {
    mode: 'Incremental'
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      resources: []
    }
  }
}

resource app 'Microsoft.Web/sites@2022-03-01' = {
  name: name
  location: location
  kind: kind
  tags: tags
  identity: identity
  properties: {
    serverFarmId: serverFarmResourceId
    clientAffinityEnabled: clientAffinityEnabled
    httpsOnly: httpsOnly
    hostingEnvironmentProfile: !empty(appServiceEnvironmentId) ? {
      id: appServiceEnvironmentId
    } : null
    storageAccountRequired: storageAccountRequired
    keyVaultReferenceIdentity: !empty(keyVaultAccessIdentityResourceId) ? keyVaultAccessIdentityResourceId : null
    virtualNetworkSubnetId: !empty(virtualNetworkSubnetId) ? virtualNetworkSubnetId : any(null)
    siteConfig: siteConfig
    vnetImagePullEnabled: vnetImagePull
    vnetRouteAllEnabled: true
    vnetContentShareEnabled: false
  }
}

module app_appsettings 'config-appsettings/deploy.bicep' = if (!empty(appSettingsKeyValuePairs)) {
  name: '${uniqueString(deployment().name, location)}-Site-Config-AppSettings'
  params: {
    stgaccess: stgaccess
    stgdirectusname: stgdirectusname
    appName: app.name
    kind: kind
    storageAccountId: storageAccountId
    appInsightId: appInsightId
    appSettingsKeyValuePairs: appSettingsKeyValuePairs
    enableDefaultTelemetry: enableReferencedModulesTelemetry
  }
}
module app_appsettingsfunction 'config-appsettings/deployfunction.bicep' = if (!empty(appSettingsKeyValuePairsfunction)) {
  name: '${uniqueString(deployment().name, location)}-Site-Config-AppSettingsfunction'
  params: {
    stgaccess: stgaccess
    stgfunctionname: stgfunctionname
    appName: app.name
    kind: kind
    storageAccountId: storageAccountId
    appInsightId: appInsightId
    appSettingsKeyValuePairsfunction: appSettingsKeyValuePairsfunction
    enableDefaultTelemetry: enableReferencedModulesTelemetry
  }
}


module app_authsettingsv2 'config-authsettingsv2/deploy.bicep' = if (!empty(authSettingV2Configuration)) {
  name: '${uniqueString(deployment().name, location)}-Site-Config-AuthSettingsV2'
  params: {
    appName: app.name
    kind: kind
    authSettingV2Configuration: authSettingV2Configuration
    enableDefaultTelemetry: enableReferencedModulesTelemetry
    
  }
}

@batchSize(1)
module app_slots 'slots/deploy.bicep' = [for (slot, index) in slots: {
  name: '${uniqueString(deployment().name, location)}-Slot-${slot.name}'
  params: {
    name: slot.name
    appName: app.name
    location: location
    kind: kind
    serverFarmResourceId: serverFarmResourceId
    httpsOnly: contains(slot, 'httpsOnly') ? slot.httpsOnly : httpsOnly
    appServiceEnvironmentId: !empty(appServiceEnvironmentId) ? appServiceEnvironmentId : ''
    clientAffinityEnabled: contains(slot, 'clientAffinityEnabled') ? slot.clientAffinityEnabled : clientAffinityEnabled
    systemAssignedIdentity: contains(slot, 'systemAssignedIdentity') ? slot.systemAssignedIdentity : systemAssignedIdentity
    userAssignedIdentities: contains(slot, 'userAssignedIdentities') ? slot.userAssignedIdentities : userAssignedIdentities
    keyVaultAccessIdentityResourceId: contains(slot, 'keyVaultAccessIdentityResourceId') ? slot.keyVaultAccessIdentityResourceId : keyVaultAccessIdentityResourceId
    storageAccountRequired: contains(slot, 'storageAccountRequired') ? slot.storageAccountRequired : storageAccountRequired
    virtualNetworkSubnetId: contains(slot, 'virtualNetworkSubnetId') ? slot.virtualNetworkSubnetId : virtualNetworkSubnetId
    siteConfig: contains(slot, 'siteConfig') ? slot.siteConfig : siteConfig
    storageAccountId: contains(slot, 'storageAccountId') ? slot.storageAccountId : storageAccountId
    appInsightId: contains(slot, 'appInsightId') ? slot.appInsightId : appInsightId
    authSettingV2Configuration: contains(slot, 'authSettingV2Configuration') ? slot.authSettingV2Configuration : authSettingV2Configuration
    enableDefaultTelemetry: enableReferencedModulesTelemetry
    diagnosticLogsRetentionInDays: contains(slot, 'diagnosticLogsRetentionInDays') ? slot.diagnosticLogsRetentionInDays : diagnosticLogsRetentionInDays
    diagnosticStorageAccountId: contains(slot, 'diagnosticStorageAccountId') ? slot.diagnosticStorageAccountId : diagnosticStorageAccountId
    diagnosticWorkspaceId: contains(slot, 'diagnosticWorkspaceId') ? slot.diagnosticWorkspaceId : diagnosticWorkspaceId
    diagnosticEventHubAuthorizationRuleId: contains(slot, 'diagnosticEventHubAuthorizationRuleId') ? slot.diagnosticEventHubAuthorizationRuleId : diagnosticEventHubAuthorizationRuleId
    diagnosticEventHubName: contains(slot, 'diagnosticEventHubName') ? slot.diagnosticEventHubName : diagnosticEventHubName
    diagnosticLogCategoriesToEnable: contains(slot, 'diagnosticLogCategoriesToEnable') ? slot.diagnosticLogCategoriesToEnable : diagnosticLogCategoriesToEnable
    diagnosticMetricsToEnable: contains(slot, 'diagnosticMetricsToEnable') ? slot.diagnosticMetricsToEnable : diagnosticMetricsToEnable
    roleAssignments: contains(slot, 'roleAssignments') ? slot.roleAssignments : roleAssignments
    appSettingsKeyValuePairs: contains(slot, 'appSettingsKeyValuePairs') ? slot.appSettingsKeyValuePairs : appSettingsKeyValuePairs
    appSettingsKeyValuePairsfunction: contains(slot, 'appSettingsKeyValuePairsfunction') ? slot.appSettingsKeyValuePairsfunction : appSettingsKeyValuePairsfunction

    lock: contains(slot, 'lock') ? slot.lock : lock
    privateEndpoints: contains(slot, 'privateEndpoints') ? slot.privateEndpoints : privateEndpoints
    tags: tags
  }
}]

resource app_lock 'Microsoft.Authorization/locks@2020-05-01' = if (!empty(lock)) {
  name: '${app.name}-${lock}-lock'
  properties: {
    level: any(lock)
    notes: lock == 'CanNotDelete' ? 'Cannot delete resource or child resources.' : 'Cannot modify the resource or child resources.'
  }
  scope: app
}

resource app_diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (!empty(diagnosticStorageAccountId) || !empty(diagnosticWorkspaceId) || !empty(diagnosticEventHubAuthorizationRuleId) || !empty(diagnosticEventHubName)) {
  name: diagnosticSettingsName
  properties: {
    storageAccountId: !empty(diagnosticStorageAccountId) ? diagnosticStorageAccountId : null
    workspaceId: !empty(diagnosticWorkspaceId) ? diagnosticWorkspaceId : null
    eventHubAuthorizationRuleId: !empty(diagnosticEventHubAuthorizationRuleId) ? diagnosticEventHubAuthorizationRuleId : null
    eventHubName: !empty(diagnosticEventHubName) ? diagnosticEventHubName : null
    metrics: diagnosticsMetrics
    logs: diagnosticsLogs
  }
  scope: app
}

resource app_diagnosticSettingsauditapp 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (!empty(diagnosticStorageAccountId) || !empty(diagnosticWorkspaceIdauditapp) || !empty(diagnosticEventHubAuthorizationRuleId) || !empty(diagnosticEventHubName)) {
  name: diagnosticSettingsNameauditapp
  properties: {
    storageAccountId: !empty(diagnosticStorageAccountId) ? diagnosticStorageAccountId : null
    workspaceId: !empty(diagnosticWorkspaceIdauditapp) ? diagnosticWorkspaceIdauditapp : null
    eventHubAuthorizationRuleId: !empty(diagnosticEventHubAuthorizationRuleId) ? diagnosticEventHubAuthorizationRuleId : null
    eventHubName: !empty(diagnosticEventHubName) ? diagnosticEventHubName : null
    logs: [
      {
        category: 'AppServiceAuditLogs'
        enabled: true
        retentionPolicy: {
          enabled: true
          days: diagnosticLogsRetentionInDays
        }
      }
      {
        category: 'AppServiceIPSecAuditLogs'
        enabled: true
        retentionPolicy: {
          enabled: true
          days: diagnosticLogsRetentionInDays
        }
      }
    ]
  }
  scope: app
}

resource app_diagnosticSettingsaudit 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (!empty(diagnosticStorageAccountId) || !empty(diagnosticWorkspaceIdaudit) || !empty(diagnosticEventHubAuthorizationRuleId) || !empty(diagnosticEventHubName)) {
  name: diagnosticSettingsNameaudit
  properties: {
    storageAccountId: !empty(diagnosticStorageAccountId) ? diagnosticStorageAccountId : null
    workspaceId: !empty(diagnosticWorkspaceIdaudit) ? diagnosticWorkspaceIdaudit : null
    eventHubAuthorizationRuleId: !empty(diagnosticEventHubAuthorizationRuleId) ? diagnosticEventHubAuthorizationRuleId : null
    eventHubName: !empty(diagnosticEventHubName) ? diagnosticEventHubName : null
    logs: diagnosticsLogs
  }
  scope: app
}


module app_roleAssignments '.bicep/nested_roleAssignments.bicep' = [for (roleAssignment, index) in roleAssignments: {
  name: '${uniqueString(deployment().name, location)}-Site-Rbac-${index}'
  params: {
    description: contains(roleAssignment, 'description') ? roleAssignment.description : ''
    principalIds: roleAssignment.principalIds
    principalType: contains(roleAssignment, 'principalType') ? roleAssignment.principalType : ''
    roleDefinitionIdOrName: roleAssignment.roleDefinitionIdOrName
    condition: contains(roleAssignment, 'condition') ? roleAssignment.condition : ''
    delegatedManagedIdentityResourceId: contains(roleAssignment, 'delegatedManagedIdentityResourceId') ? roleAssignment.delegatedManagedIdentityResourceId : ''
    resourceId: app.id
  }
}]

module app_privateEndpoints '../../Networking/privateEndpoints/Privateendpoint.bicep' = [for (privateEndpoint, index) in privateEndpoints: {
  name: '${uniqueString(deployment().name, location)}-Site-PrivateEndpoint-${index}'
  params: {
    groupIds: [
      privateEndpoint.service
    ]
    name: contains(privateEndpoint, 'name') ? privateEndpoint.name : 'pe-${last(split(app.id, '/'))}-${privateEndpoint.service}-${index}'
    serviceResourceId: app.id
    subnetResourceId: privateEndpoint.subnetResourceId
    enableDefaultTelemetry: enableReferencedModulesTelemetry
    location: reference(split(privateEndpoint.subnetResourceId, '/subnets/')[0], '2020-06-01', 'Full').location
    lock: contains(privateEndpoint, 'lock') ? privateEndpoint.lock : lock
    privateDnsZoneGroup: contains(privateEndpoint, 'privateDnsZoneGroup') ? privateEndpoint.privateDnsZoneGroup : {}
    tags: contains(privateEndpoint, 'tags') ? privateEndpoint.tags : {}
    manualPrivateLinkServiceConnections: contains(privateEndpoint, 'manualPrivateLinkServiceConnections') ? privateEndpoint.manualPrivateLinkServiceConnections : []
    customDnsConfigs: contains(privateEndpoint, 'customDnsConfigs') ? privateEndpoint.customDnsConfigs : []
    ipConfigurations: contains(privateEndpoint, 'ipConfigurations') ? privateEndpoint.ipConfigurations : []
    applicationSecurityGroups: contains(privateEndpoint, 'applicationSecurityGroups') ? privateEndpoint.applicationSecurityGroups : []
    customNetworkInterfaceName: contains(privateEndpoint, 'customNetworkInterfaceName') ? privateEndpoint.customNetworkInterfaceName : ''
  }
}]

type managedIdentitiesType = {
  @description('Optional. Enables system assigned managed identity on the resource.')
  systemAssigned: bool?

  @description('Optional. The resource ID(s) to assign to the resource.')
  userAssignedResourceIds: string[]?
}?






// =========== //
// Outputs     //
// =========== //

@description('The principal ID of the system assigned identity.')
output systemAssignedMIPrincipalId string = (managedIdentities.?systemAssigned ?? false) && contains(app.identity, 'principalId') ? app.identity.principalId : ''



@description('The name of the site.')
output name string = app.name

@description('The resource ID of the site.')
output resourceId string = app.id

@description('The resource ID of the site.')
output Principle string = app.id

@description('The list of the slots.')
output slots array = [for (slot, index) in slots: app_slots[index].name]

@description('The list of the slot resource ids.')
output slotResourceIds array = [for (slot, index) in slots: app_slots[index].outputs.resourceId]

@description('The resource group the site was deployed into.')
output resourceGroupName string = resourceGroup().name

@description('The principal ID of the system assigned identity.')
output systemAssignedPrincipalId string = systemAssignedIdentity && contains(app.identity, 'principalId') ? app.identity.principalId : ''

@description('The principal ID of the system assigned identity of slots.')
output slotSystemAssignedPrincipalIds array = [for (slot, index) in slots: app_slots[index].outputs.systemAssignedPrincipalId]

@description('The location the resource was deployed into.')
output location string = app.location

@description('Default hostname of the app.')
output defaultHostname string = app.properties.defaultHostName

output outboundip array = array(app.properties.possibleOutboundIpAddresses)
