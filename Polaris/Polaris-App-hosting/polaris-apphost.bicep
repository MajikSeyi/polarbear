targetScope = 'subscription'


//// Parameters ////

@description('This is a private dns zone which will hold a custom domain name string')
 param privatednsmicro string


@description('Resource group for Spring applications.')
param rg_springapp string 

@description('The resource group for the virtual networking')
param rgvirtualnetworking string 

@description('The resource group for the runtime networking resources')
param RuntimeNetworkResourceGroup string 

@description('The name for the load balancer check')
param lbcheckname string = 'kubernetes-internal'

@description('The resource group for the application networking resources')
param appNetworkResourceGroup string

@description('The resource group for the static web app')
param rgstaticwebapp string 

@description('The resource group for Directus.')
param rg_directus string 

@description('The resource group for Directus storage.')
param rg_directusstorage string 

@description('The resource group for malware scanning')
param rg_malwarescanning string

@description('The resource group for shared monitoring')
param rg_shared_monitoring string 

@description('The resource group for document storage')
param rg_documentstorage string

@description('The location for the static web app')
param swalocation string 

@description('The URL for the static web app repo.')
param swarepourl string

@description('The URL for the static web app repo used with B2C.')
param swarepourlb2c string

@description('The branch for the static web app.')
param swabranch string

@description('The location for resources in the UK South region.')
param ukslocation string 


@description('The name for the static web app.')
@minLength(3)
@maxLength(40)
param swaname string = 'swa-frontend-polaris-'

@description('The name for the static web app used with B2C')
param swadb2c string = 'swa-adb2c-custom-ui-polaris-'

@description('The environment name.')
@minLength(3)
@maxLength(40)
param env string

@description('Directus environment name.NOTE - Prod must be called Production')
param acrenv string 

@description('The shared environment name.')
param envshared string

@description('The name for the Spring app.')
param springCloudInstanceName string

@description('The CIDR blocks for the Spring Cloud service.')
param springCloudServiceCidrs string = '10.0.0.0/16,10.2.0.0/16,10.3.0.1/16'

@description('The name for the calendar service.')
param calendarservice string 

@description('The subscription for shared monitoring.')
param sharedmonitorsubscription string

@description('The endpoint for the application configuration.')
param appconfig_endpoint string

@description('The name for the course.')
param coursename string

@description('The name for the participant.')
param participantename string

@description('The name for the communication service.')
param communicationname string

@description('The name for the username service.')
param usernameservice string

@description('The Directus management settings.')
param directusmanagement string

@description('The name for the documents service.')
param documentsservice string

@description('The name for the recruitment service.')
param recruitmentservice string

@description('Indicates whether resources for the Spring app exist.')
param resourcespringappExists bool

@description('Indicates whether an untrusted storage account is present.')
param untrustedstgpresent bool

@description('The path for the application configuration.')
param appconfigpath string

@description('The resource group for automation resources.')
param rgautomation string = 'rg-automation'

@description('the array values of availability test names and request url')
param availabilitytestparams array

@description('Interval in seconds between test runs for the availability test.')
param frequency int 

@description('Seconds until the availability test will timeout and fail.')
param timeout int 

@description('Optional. Maps to the \'odata.type\' field. Specifies the type of the alert criteria.')
param alertCriteriaType string

@description('Optional. The flag that indicates whether the alert should be auto resolved or not.')
param autoMitigate bool 

@description('Optional. The severity of the alert.')
param severity int 

@description('Optional. how often the metric alert is evaluated represented in ISO 8601 duration format.')
param evaluationFrequency string 

@description('Optional. the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold.')
param windowSize string

@description('Name of the App Service Plan SKU.')
param aspSkuName string

@description('Service tier of the App Service Plan SKU.')
param aspSkuTier string

@description('Size specifier of the App Service Plan SKU.')
param aspSkuSize string

@description('Family code of the App Service Plan SKU.')
param aspSkuFamily string

@description('Current number of instances assigned to the App Service Plan SKU.')
param aspSkuCapacity int

@description('Spring app zone redundancy')
param zoneRedundant bool



//// Dependancy////



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

resource lawaudit 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: 'm365azuresentinel-dw-prod-uks-la'
  scope: resourceGroup('e7fe7e3e-7874-4903-87be-422595a82d07','it-dw-sentinel-logs-production-rg' )
}




// Application Insights
module appinsightfunctionapp '../../modules/Microsoft.Insights/components/deploy.bicep' = {
  scope: resourceGroup(rg_malwarescanning)
  name: 'aifunctionapp${env}${uniqueString(deployment().name)}' 
  params: {
    name: 'ai-functionapp-malwarescan-polaris-${env}-${ukslocation}' 
    workspaceResourceId: law.outputs.lawop
    location: ukslocation 
  }
}

module springappinsight '../../modules/Microsoft.Insights/components/deploy.bicep' = {
  scope: resourceGroup(rg_springapp)
  name: 'aispingapp${env}${uniqueString(deployment().name)}' 
  params: {
    name: 'ai-springapps-polaris-${env}-${ukslocation}' 
    workspaceResourceId: law.outputs.lawop 
    location: ukslocation 
  }
}


//Availabilty tests for Application insights

module availabilitytests '../../modules/Microsoft.Insights/webtests/deploy.bicep' = [for (param, index) in availabilitytestparams: {
  scope: resourceGroup(rg_springapp)
  name: 'availabilty-test-${env}${uniqueString(deployment().name)}-${index}'
  params: {
    name: '${param.webTestName}-ai-springapps-polaris-${env}-${ukslocation}'
    location: ukslocation
    frequency: frequency
    timeout: timeout
    appInsightResourceId: springappinsight.outputs.resourceId
    webTestName: param.webTestName
    request: {
      RequestUrl: param.requestUrl
      HttpVerb: 'GET'
    }
  }
}]

//Metric alerts for App Insight's availability tests

module availabilitytestmetricalerts './polaris-availibility-tests-alert.bicep' = [for (parameter, index) in availabilitytestparams: {
  scope: resourceGroup(rg_springapp)
  name: 'metric-alerts-${env}${uniqueString(deployment().name)}-${index}'
  params: {
    name: '${parameter.webTestName}-ai-springapps-polaris-${env}-${ukslocation}'
    tags: {
      'hidden-link:${springappinsight.outputs.resourceId}':'Resource'
      'hidden-link:${availabilitytests[index].outputs.resourceId}': 'Resource'
    }
    scopes: [
      springappinsight.outputs.resourceId, availabilitytests[index].outputs.resourceId
    ]
    alertDescription: 'metric alert created for ${availabilitytests[index].outputs.name}'
    location: 'Global'
    alertCriteriaType: alertCriteriaType
    evaluationFrequency: evaluationFrequency
    windowSize: windowSize
    severity: severity
    enabled: false
    autoMitigate:autoMitigate
    criterias: {
        webTestId: availabilitytests[index].outputs.resourceId
        componentId: springappinsight.outputs.resourceId
        failedLocationCount: 1
      } 
  }
  dependsOn: [
    springappinsight,availabilitytests[index]
  ]
}]

//STG directus
resource stgdirectusname 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: 'sadirectuspolaris${env}'
  scope: resourceGroup(rg_directusstorage)
}

//VNET
// vnet resource 
resource appvnet 'Microsoft.Network/virtualNetworks@2021-08-01' existing = {
  name: 'vnet-polaris-${env}-${ukslocation}'
  scope: resourceGroup(rgvirtualnetworking)
}
resource subnetapp 'Microsoft.Network/virtualnetworks/subnets@2015-06-15' existing = {
  name: 'SpringAppsApplicationsSubnet'
  parent: appvnet
}
resource subnetruntime 'Microsoft.Network/virtualnetworks/subnets@2015-06-15' existing = {
  name: 'SpringAppsRuntimeSubnet'
  parent: appvnet
}
resource subnetprivatelink 'Microsoft.Network/virtualnetworks/subnets@2015-06-15' existing = {
  name: 'PrivateLinkSubnet'
  parent: appvnet
}

resource subnetprivateendpoint'Microsoft.Network/virtualnetworks/subnets@2015-06-15' existing = {
  name: 'PrivateEndpointsSubnet'
  parent: appvnet
}

resource subnetAppServicesSubnet 'Microsoft.Network/virtualnetworks/subnets@2015-06-15' existing = {
  name: 'AppServicesSubnet'
  parent: appvnet
}

//DNS
resource privatednsazurewebsites 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: 'privatelink.azurewebsites.net'
  scope: resourceGroup(rg_springapp)
}

//// Static web app ////
// swa-frontend
module swareed '../../modules/Microsoft.Web/staticSites/swa.bicep' = {
  scope: resourceGroup(rgstaticwebapp)
  name: '${uniqueString(deployment().name)}-${env}-swa'
  params: {
    repositoryUrl: swarepourl
    branch: swabranch
    stagingEnvironmentPolicy: 'Enabled'
    allowConfigFileUpdates: true
    provider: 'GitHub'
    sku: 'Standard'
    name: '${swaname}${env}'
    location: swalocation
  }
}

// swa-adb2c-custom-ui-polaris

module swaadb2c '../../modules/Microsoft.Web/staticSites/swa.bicep' = {
  scope: resourceGroup(rgstaticwebapp)
  name: '${uniqueString(deployment().name)}-${env}-swa-ad2b'
  params: {
    repositoryUrl: swarepourlb2c
    branch: swabranch
    stagingEnvironmentPolicy: 'Enabled'
    allowConfigFileUpdates: true
    provider: 'GitHub'
    sku: 'Standard'
    name: '${swadb2c}${env}'
    location: swalocation
  }
}

//// Sping app deployment ////

resource automationaccount 'Microsoft.Automation/automationAccounts@2022-08-08' existing = {
  name: 'automation-polaris-${env}-${ukslocation}'
  scope: resourceGroup(rgautomation)

}

module azurespringapp '../../modules/Application.platform/Azurespringapp/azurespingapp.bicep' =  {
  scope: resourceGroup(rg_springapp)
  name: 'asa-deployment-${env}'
  params: {
    resourceExists: resourcespringappExists
    appconfig_endpoint: appconfig_endpoint
    sharedenv: envshared
    sharedmonitorsubscription: sharedmonitorsubscription
    rg_shared_monitoring: rg_shared_monitoring
    env: env
    ukslocation: ukslocation
    zoneRedundant: zoneRedundant
    roleAssignments: [
      {
        principalIds: [
          automationaccount.identity.principalId
        ]
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Azure Spring Cloud Data Reader'
      }
    ]
    calendarservice : calendarservice
    coursename: coursename
    participantename: participantename
    communicationname: communicationname
    usernameservice: usernameservice
    directusmanagement: directusmanagement
    documentsservice: documentsservice
    recruitmentservice: recruitmentservice
    location: ukslocation 
    springCloudAppSubnetID: subnetapp.id
    springCloudInstanceName: springCloudInstanceName 
    springCloudRuntimeSubnetID: subnetruntime.id
    springCloudServiceCidrs: springCloudServiceCidrs
    appNetworkResourceGroup: appNetworkResourceGroup
    RuntimeNetworkResourceGroup: RuntimeNetworkResourceGroup

  }
}

//// Azure App Configuration 
module appconfig '../../modules/AppConfiguration/configurationStores/appconfig.bicep' = {
  scope: resourceGroup(rg_springapp)
  name:'${uniqueString(deployment().name)}-${env}-appcon' 
  params: {
    name: 'appconfig-spring-polaris-${env}-${ukslocation}'
    location: ukslocation
    sku: 'Standard'
    systemAssignedIdentity: true
    publicNetworkAccess: 'Enabled'
    disableLocalAuth: false
    softDeleteRetentionInDays: 7
    enablePurgeProtection: false
    roleAssignments: [
      {
        principalIds: [
          azurespringapp.outputs.app_calandar_service_principleid
          azurespringapp.outputs.app_communication_service_principleid
          azurespringapp.outputs.app_course_service_principleid
          azurespringapp.outputs.app_directus_management_service_principleid
          azurespringapp.outputs.app_document_service_principleid
          azurespringapp.outputs.app_participant_service_principleid
          azurespringapp.outputs.app_recruitment_service_principleid
          azurespringapp.outputs.app_user_service_principleid
        ]
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'App Configuration Data Reader'
      }
    ]

    diagnosticWorkspaceId: law.outputs.lawop
    diagnosticWorkspaceIdaudit: lawaudit.id
  }
}

//// Key Vault RBAC ////

module kvspringappv2 '../../modules/Security/Microsoft.KeyVault/vaults/deploy.bicep' = {
  scope: resourceGroup(rg_springapp)
  name: '${uniqueString(deployment().name)}-${env}-kvspringapp'
  params: {
    name: 'kv-polaris-${env}-${ukslocation}'  
    diagnosticWorkspaceId: law.outputs.lawop
    diagnosticLogsRetentionInDays:0
    diagnosticWorkspaceIdAudit: lawaudit.id
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
    roleAssignments: [
      {
        principalIds: [
          appconfig.outputs.systemAssignedPrincipalId
          azurespringapp.outputs.app_calandar_service_principleid
          azurespringapp.outputs.app_communication_service_principleid
          azurespringapp.outputs.app_course_service_principleid
          azurespringapp.outputs.app_directus_management_service_principleid
          azurespringapp.outputs.app_document_service_principleid
          azurespringapp.outputs.app_participant_service_principleid
          azurespringapp.outputs.app_recruitment_service_principleid
          azurespringapp.outputs.app_user_service_principleid
        ]
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Key Vault Secrets User'
      }
    ]
  }
}



// Private link to spring apps
module plspringapplb '../../modules/Networking/privateLinkServices/privatelink.bicep' = {
  scope: resourceGroup(rgvirtualnetworking)
  name: 'privatelink-deployment-${env}' 
  params: {
    loadBalancerFrontendIpConfigurations: lbcheck.properties.frontendIPConfigurations
    name: 'pl-springapps-polaris-${env}'
    location: ukslocation
    ipConfigurations: [
      {
        name: 'pl_ipconfig_1'
        properties: {
          primary: true 
          privateIPAllocationMethod: 'Dynamic'
          privateIPAddressVersion: 'IPv4'
          subnet: {
            id: subnetprivatelink.id
          }
        }
      }
    ]
  }
  dependsOn: [
    lbarecord
  ]
}

// * A record for load balancer

resource lbcheck 'Microsoft.Network/loadBalancers@2022-07-01' existing = {
  name: lbcheckname
  scope: resourceGroup(RuntimeNetworkResourceGroup)
  
}


module lbarecord '../../modules/Networking/privateDnsZones/A/deploy.bicep' = {
  scope:  resourceGroup(rg_springapp)
  name: '${uniqueString(deployment().name)}-dnsarecord'
  params: {
    aRecords: [
        {
          ipv4Address: lbcheck.properties.frontendIPConfigurations[0].properties.privateIPAddress
        }
    ] 
    name: '*' 
    privateDnsZoneName: privatednsmicro 
  }
  dependsOn:[
    azurespringapp
    
  ]
}


//// Managed Identity for Directus and Malware Scanning 


// Malware scanning
module userAssignedIdentitymalwarescan '../../modules/managed-identity/user-assigned-identity/main.bicep' = {
  name: '${uniqueString(deployment().name)}-snd-malwarescan'
  scope: resourceGroup(rg_malwarescanning) 
  params: {
    name: 'mi-as-app-malwarescan-polaris-${env}-${ukslocation}'

  }
}

// Directus

module userAssignedIdentitydirectus '../../modules/managed-identity/user-assigned-identity/main.bicep' = {
  name: '${uniqueString(deployment().name)}-snd-directus'
  scope: resourceGroup(rg_directus) 
  params: {
    name: 'mi-as-app-directus-polaris-${env}-${ukslocation}'
  }
}

// Directus and malware permissions
resource acr 'Microsoft.ContainerRegistry/registries@2019-05-01' existing = {
  name: 'crreedsharedproduction'
  scope: resourceGroup('3592b1b4-dca4-42c2-95dc-bf0902211479', 'rg-shared-containerregistries') 
}


module containerregistries '../../modules/Microsoft.ContainerRegistry/registries/.bicep/nested_roleAssignments.bicep' = {
  scope: resourceGroup('3592b1b4-dca4-42c2-95dc-bf0902211479', 'rg-shared-containerregistries')  
  name: guid(userAssignedIdentitydirectus.name, 'acrpull')
  params: {
    principalIds: [
      userAssignedIdentitydirectus.outputs.principalId
      userAssignedIdentitymalwarescan.outputs.principalId
    ] 
    resourceId: acr.id  
    roleDefinitionIdOrName: 'AcrPull' 
  }
}


//// Directus Container instance & App Service Plan ////

// Directus Service Plan
module appservicdirectus '../../modules/Microsoft.Web/serverfarms/deploy.bicep' = {
  scope: resourceGroup(rg_directus)
  name: '${uniqueString(deployment().name)}-appservice-directus'
  params: {
    name: 'as-plan-directus-polaris-${env}-${ukslocation}'
    sku: {
      capacity: aspSkuCapacity
      family: aspSkuFamily
      name: aspSkuName
      size: aspSkuSize
      tier: aspSkuTier
    }
    serverOS: 'Linux'
    diagnosticWorkspaceId: law.outputs.lawop
    zoneRedundant: zoneRedundant
  
  }
}

// Directus App Service

module directusappservice '../../modules/Microsoft.Web/sites/deploy.bicep' = {
  scope: resourceGroup(rg_directus)
  name: '${uniqueString(deployment().name)}-appservice1-directus'
  params: {
    vnetImagePull: false
    // resourcegroup: rg_directus
    stgdirectusname: stgdirectusname.name
    stgaccess: stgdirectusname.listKeys().keys[0].value
    kind: 'app'
    name: 'as-app-directus-polaris-${env}-${ukslocation}'
    serverFarmResourceId: appservicdirectus.outputs.resourceId
    virtualNetworkSubnetId: subnetAppServicesSubnet.id
    managedIdentities: {
      userAssignedResourceIds:[
        userAssignedIdentitydirectus.outputs.resourceId
      ]
    }
    diagnosticWorkspaceId: law.outputs.lawop
    diagnosticWorkspaceIdauditapp: lawaudit.id
    systemAssignedIdentity: false

    appSettingsKeyValuePairs: {
      CONFIG_PATH: appconfigpath //'/directus/configuration/test-configuration.yaml' 
    }
    privateEndpoints: [
      {
        privateDnsZoneGroup: {
          privateDNSResourceIds: [
            privatednsazurewebsites.id
          ]
        }
        service: 'sites'
        subnetResourceId: subnetprivateendpoint.id
      }
    ]
    siteConfig: {
      acrUseManagedIdentityCreds: true
      acrUserManagedIdentityID : userAssignedIdentitydirectus.outputs.clientId 
      httpLoggingEnabled: true
      linuxFxVersion: 'DOCKER|crreedsharedproduction.azurecr.io/reedinpartnership/polaris/directus:${acrenv}'
      alwaysOn: true
      ftpsState: 'Disabled'
      publicNetworkaccess: 'Disabled'
      healthCheckPath: '/server/health'
    }
  }
}
// Malwarescan App Service ( Function App)

//STG Functionapp //
resource stgfunctionapp 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: 'safunctionspolaris${env}'
  scope: resourceGroup(rg_malwarescanning)
}

resource stgdoc 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: 'sadocstoragepolaris${env}' 
  scope: resourceGroup(rg_documentstorage)
}

resource stguntrusted 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: 'sauntrustedpolaris${env}' 
  scope: resourceGroup(rg_malwarescanning)
}



module malwarefunctionappFunction '../../modules/Microsoft.Web/sites/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-test-wsfacom'
  scope: resourceGroup(rg_malwarescanning)
  params: {
    vnetImagePull: false
    kind: 'functionapp,linux'
    name: 'as-app-malwarescan-polaris-${env}-${ukslocation}'
    virtualNetworkSubnetId: subnetAppServicesSubnet.id
    stgdirectusname: stgfunctionapp.name
    stgaccess: stgfunctionapp.listKeys().keys[0].value
    serverFarmResourceId: appservicdirectus.outputs.resourceId
    diagnosticWorkspaceId: law.outputs.lawop
    
    diagnosticWorkspaceIdaudit: lawaudit.id
    managedIdentities: {
      systemAssigned: true
      userAssignedResourceIds:[
        userAssignedIdentitymalwarescan.outputs.resourceId
      ]
    }
    
    appInsightId: appinsightfunctionapp.outputs.resourceId
    storageAccountId: stgfunctionapp.name   
    appSettingsKeyValuePairsfunction: {
      DOCKER_REGISTRY_SERVER_URL: 'https://crreedsharedproduction.azurecr.io'
      AzureFunctionsJobHost__logging__logLevel__default: 'Debug'
      WEBSITE_HEALTHCHECK_MAXPINGFAILURES: '10'
      WEBSITE_HTTPLOGGING_RETENTION_DAYS: '7'
      WEBSITES_ENABLE_APP_SERVICE_STORAGE: false
      FUNCTIONS_EXTENSION_VERSION: '~4'
      FUNCTIONS_WORKER_RUNTIME: 'java'
      SCAN_MALWARE_QUEUENAME: 'malwarescans'
      SCAN_MALWARE_CONNECTIONSTRING__QUEUESERVICEURI: stguntrusted.properties.primaryEndpoints.queue  
      SCAN_ACCEPTED_CONTAINER_URI: 'https://sadocstoragepolaris${env}.blob.core.windows.net/accepteddocuments'
      SCAN_QUARANTINE_CONTAINER_URI: 'https://saquarantinepolaris${env}.blob.core.windows.net/quarantine'
      SCAN_NOTIFICATIONS_CONNECTIONSTRING__QUEUESERVICEURI: stgdoc.properties.primaryEndpoints.queue
      SCAN_NOTIFICATIONS_QUEUENAME: 'notifications'
      SCAN_NOTIFICATIONS_QUEUETTLDAYS: '7'
      UPLOAD_HOSTHEADER: 'as-app-malwarescan-polaris-${env}-uksouth.azurewebsites.net'
      UPLOAD_CONTAINER_URI: 'https://sauntrustedpolaris${env}.blob.core.windows.net/uploads'
      UPLOAD_NOTIFICATIONS_CONNECTIONSTRING__QUEUESERVICEURI: stgdoc.properties.primaryEndpoints.queue
      UPLOAD_NOTIFICATIONS_QUEUENAME: 'notifications'
      UPLOAD_NOTIFICATIONS_QUEUETTLDAYS: '7'

    }
    privateEndpoints: [
      {
        privateDnsZoneGroup: {
          privateDNSResourceIds: [
            privatednsazurewebsites.id
          ]
        }
        service: 'sites'
        subnetResourceId: subnetprivateendpoint.id
      }
    ]
    siteConfig: {
      httpLoggingEnabled: true
      acrUseManagedIdentityCreds: true
      acrUserManagedIdentityID : userAssignedIdentitymalwarescan.outputs.clientId
      linuxFxVersion: 'DOCKER|crreedsharedproduction.azurecr.io/reedinpartnership/polaris/azure/storage/scanning:${acrenv}'
      alwaysOn: true
      ftpsState: 'Disabled'
      publicNetworkaccess: 'Disabled'
      healthCheckPath: '/api/health'
    }
    systemAssignedIdentity: true
  }
}

// STG Function permissions

resource eventgrid 'Microsoft.EventGrid/topics@2022-06-15' existing = {
  name: 'egt-untrusted-storage-malwarescan-${env}'
  scope: resourceGroup(rg_malwarescanning)
}


module stgaclpermissions '../../modules/Storage/storageAccounts/stg_dfsenabled.bicep' = if (untrustedstgpresent == true) {
  scope: resourceGroup(rg_malwarescanning)
  name: 'stgdeploydmzaddacl${env}${uniqueString(deployment().name)}-permissions' 
  params: {
    name: 'sauntrustedpolaris${env}' 
    storageAccountSku: 'Standard_ZRS'
    scanResultsEventGridTopicResourceId: eventgrid.id
    networkAcls: {
      resourceAccessRules: [
      {
          action: 'Allow'
          id: eventgrid.id
      }
      ]
      bypass: 'AzureServices'
      virtualNetworkRules: []
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
          name: 'uploads'
          roleAssignments: [
            {
              principalIds: [
                malwarefunctionappFunction.outputs.systemAssignedPrincipalId
              ]
              principalType: 'ServicePrincipal'
              roleDefinitionIdOrName: 'Storage Blob Data Contributor'
            }
          ]
        }
      ]

    }
    queueServices: {
      queues: [
        {
          metadata: {
          }
          name: 'malwarescans'
          roleAssignments: [
            {
              principalIds: [
                malwarefunctionappFunction.outputs.systemAssignedPrincipalId
              ]
              principalType: 'ServicePrincipal'
              roleDefinitionIdOrName: 'Storage Queue Data Contributor'
            }
          ]

        }
        {
          metadata: {
          }
          name: 'malwarescans-poison'
          roleAssignments: [
            {
              principalIds: [
                malwarefunctionappFunction.outputs.systemAssignedPrincipalId
              ]
              principalType: 'ServicePrincipal'
              roleDefinitionIdOrName: 'Storage Queue Data Contributor'
            }
          ]

        }
      ]
    }
  }
}




module stgdocpermission '../../modules/Storage/storageAccounts/stg.bicep' = {
  scope: resourceGroup(rg_documentstorage)
  name: 'stgdeploy${env}${uniqueString(deployment().name)}-permissionsdoc' 
  params: {
    name: 'sadocstoragepolaris${env}' 
    storageAccountSku: 'Standard_ZRS'
    networkAcls: {
      resourceAccessRules: []
      bypass: 'AzureServices'
      virtualNetworkRules: []
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
          name: 'storeddocuments'
          roleAssignments: [
            {
              principalIds: [
                azurespringapp.outputs.app_document_service_principleid
              ]
              principalType: 'ServicePrincipal'
              roleDefinitionIdOrName: 'Storage Blob Data Contributor'
            }
          ]
        }  
        {
          name: 'accepteddocuments'
          roleAssignments: [
            {
              principalIds: [
                malwarefunctionappFunction.outputs.systemAssignedPrincipalId
                azurespringapp.outputs.app_document_service_principleid
              ]
              principalType: 'ServicePrincipal'
              roleDefinitionIdOrName: 'Storage Blob Data Contributor'
            }
          ]
        }
      
      ]
    }
    queueServices: {
      queues: [
        {
          metadata: {
          }
          name: 'notifications'
          roleAssignments: [
            {
              principalIds: [
                malwarefunctionappFunction.outputs.systemAssignedPrincipalId
                azurespringapp.outputs.app_document_service_principleid
              ]
              principalType: 'ServicePrincipal'
              roleDefinitionIdOrName: 'Storage Queue Data Contributor'
            }
          ]

        }
      ]
    }
  }
}


module stgquarantinepermission '../../modules/Storage/storageAccounts/stg.bicep' = {
  scope: resourceGroup(rg_malwarescanning)
  name: 'stgdeploy${env}${uniqueString(deployment().name)}-permissionsquar' 
  params: {
    name: 'saquarantinepolaris${env}' 
    storageAccountSku: 'Standard_ZRS'
    networkAcls: {
      resourceAccessRules: []
      bypass: 'AzureServices'
      virtualNetworkRules: []
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
          name: 'quarantine'
          roleAssignments: [
            {
              principalIds: [
                malwarefunctionappFunction.outputs.systemAssignedPrincipalId
              ]
              principalType: 'ServicePrincipal'
              roleDefinitionIdOrName: 'Storage Blob Data Contributor'
            }
          ]
        }
      
      ]
    }
  }
}



/////////////////////////////
//// Resource Monitoring ////
/////////////////////////////



module applicationmonitor 'polaris-apphost-monitoring.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-monitor'
  params: {
    springappinsight: springappinsight.outputs.resourceId
    azurespringapp: azurespringapp.outputs.springid
    env: env
    envshared: envshared 
    rg_shared_monitoring: rg_shared_monitoring 
    rg_springapp: rg_springapp
    sharedmonitorsubscription: sharedmonitorsubscription 
    ukslocation: ukslocation
  }
}

