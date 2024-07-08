targetScope = 'subscription'

//// Parameters ////

param ukslocation string //uksouth
param env string

@description('Optional. Resource group for Spring applications.')
param rg_springapp string

@description('Optional. Standard Application configuration')
param appconfigsku string

@description('Optional. Resource group for the SQL server.')
param rg_sqlserver string

@description('Resource group for Document Storage')
param rg_documentstorage string

@description('Resource group for Shared Monitoring')
param rg_shared_monitoring string

@description('Resource group for Automation')
param rgautomation string

@description('Resource group for Directus storage')
param rg_directusstorage string

@description('Resource group for the Azure cache for Redis')
param rg_rediscache string 

@description('Resource group for Malware Scanning')
param rg_malwarescanning string

@description('Weekly retention period for databasebackup.NOTE- PT0S format')
param weekylong string 

@description('Monthly retention period for databasebackup.NOTE- PT0S format')
param monthlylong string 

@description('Yearly retention period for databasebackup.NOTE- PT0S format')
param yearlyRetention string 

@description ('Backup Storage Redundancy configuration')
param requestedBackupStorageRedundancy string 

@description('The administrator username for the server. Required if no administrators object for AAD authentication is provided.')
param administratorLogin string 

@description('The administrator login password. Required if no administrators object for AAD authentication is provided.')
@secure()
param administratorLoginPassword string  

@description('Expiration date time for maintenance window')
param mainexpire string 

@description('How many times for the maintenance to recur')
param mainrecur string 

@description('When the start date time is for the maintenance window')
param mainstart string 

@description('To set the local timezone where the maintance will happen.')
param maintimezone string 

@description('How long the duration will be')
param mainduration string 

@description('Login username for the sqlserver')
param adsqllogin string 

@description('What the Sql Service ID is - 85d74a37-0cdc-43fd-b278-eef21a4037da')
param sidsql string 

@description('The unique Tenant ID - 3d97076e-80d1-41ff-9ebb-3c9d9ee234ad')
param tentantid string 

@description('The shared monitoring subscription')
param sharedmonitorsubscription string

@description('The defined shared environment')
param envshared string

@description('Check if the STG present is untrusted, if true dont execute, if false continue and execute.')
param untrustedstgpresent bool 


@description('automation schedule start time')
param automationstartTime string

param subscriptionid string 

@description('Capacity of the particular SKU for the SQLDB')
param skuCapacity int

@description('The name of the SKU for the SQLDB')
param skuName string

param zoneRedundant bool


//// Dependancy////
module law '../../Shared-Services/Shared-Monitoring/shared-monitoring.bicep' = {
  name: 'lawop${env}${uniqueString(deployment().name)}-01'
  params: {
    sharedmonitorsubscription: sharedmonitorsubscription
    sharedenv: envshared
    rg_shared_monitoring: rg_shared_monitoring 
    ukslocation: ukslocation
  }
}
//
resource lawaudit 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: 'm365azuresentinel-dw-prod-uks-la'
  scope: resourceGroup('e7fe7e3e-7874-4903-87be-422595a82d07','it-dw-sentinel-logs-production-rg' )
}




//// Key Vault Creation ////

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
        ]
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Key Vault Secrets User'
      }
    ]
  }

}



//// Azure App Configuration 
module appconfig '../../modules/AppConfiguration/configurationStores/appconfig.bicep' = {
  scope: resourceGroup(rg_springapp)
  name:'${uniqueString(deployment().name)}-${env}-appcon' 
  params: {
    name: 'appconfig-spring-polaris-${env}-${ukslocation}'
    location: ukslocation
    sku: appconfigsku
    systemAssignedIdentity: true
    publicNetworkAccess: 'Enabled'
    disableLocalAuth: false
    softDeleteRetentionInDays: 7
    enablePurgeProtection: false
    diagnosticWorkspaceId: law.outputs.lawop
    diagnosticWorkspaceIdaudit: lawaudit.id
  }
}


//// Create Storage Account
// STG account
module stgdeploy '../../modules/Storage/storageAccounts/stg.bicep' = {
  name: 'stgdeploy${env}${uniqueString(deployment().name)}'
  scope: resourceGroup(rg_documentstorage)
  params: {
    allowSharedKeyAccess: true
    diagnosticWorkspaceId: law.outputs.lawop
    name: 'sadocstoragepolaris${env}'
    location: ukslocation
    largeFileSharesState: 'Disabled'
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
    allowCrossTenantReplication: true
    blobServices: {
      diagnosticWorkspaceId: law.outputs.lawop
    }

    queueServices: {
      queues: [
        {
          metadata: {
          }
          name: 'notifications'

        }
      ]
    }
  }
}

module stgblobdoc '../../modules/Storage/storageAccounts/blobServices/deploy.bicep' = {
  name: 'stgdeployblobdoc${env}${uniqueString(deployment().name)}'
  scope: resourceGroup(rg_documentstorage)
  params: {
    storageAccountName: stgdeploy.outputs.name
    containers: [
      
        {
          name: 'storeddocuments'
        }   
        {
          name: 'accepteddocuments'
        }
      
    ]
  }
}

// STG FunctionApp

module malwarestg '../../modules/Storage/storageAccounts/stg.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-stg'
  scope: resourceGroup(rg_malwarescanning)
  params: {
    diagnosticWorkspaceId: law.outputs.lawop
    allowSharedKeyAccess: true
    name: 'safunctionspolaris${env}'
    location: ukslocation
    largeFileSharesState: 'Disabled'
    allowCrossTenantReplication: true
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
          name: 'azure-webjobs-hosts'
        }
        {
          name: 'azure-webjobs-secrets'
        }
      ]
      diagnosticWorkspaceId: law.outputs.lawop
    }
  }
}

// STG directus account
module stgdirectus '../../modules/Storage/storageAccounts/stg.bicep' = {
  name: 'stgdeploydirectus${env}${uniqueString(deployment().name)}'
  scope: resourceGroup(rg_directusstorage)
  params: {
    diagnosticWorkspaceId: law.outputs.lawop
    allowSharedKeyAccess: true
    name: 'sadirectuspolaris${env}'
    location: ukslocation
    largeFileSharesState: 'Disabled'
    allowCrossTenantReplication: true
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
          name: 'blobname'
        }
      ]
      diagnosticWorkspaceId: law.outputs.lawop
    }
    fileServices:{
      diagnosticWorkspaceId: law.outputs.lawop
    }
  }
}

module fileshare '../../modules/Storage/storageAccounts/fileServices/shares/deploy.bicep' = {
  name: 'stgdeploydirectusfile${env}${uniqueString(deployment().name)}'
  scope: resourceGroup(rg_directusstorage)
  params: {
    accessTier: 'Cool'
    name: 'configuration'
    storageAccountName: stgdirectus.outputs.name
  }
}

module fileshare2 '../../modules/Storage/storageAccounts/fileServices/shares/deploy.bicep' = {
  name: 'stgdeploydirectusfile2${env}${uniqueString(deployment().name)}'
  scope: resourceGroup(rg_directusstorage)
  params: {
    accessTier: 'Cool'
    name: 'uploads'
    storageAccountName: stgdirectus.outputs.name
  }
}

// DMZ storage account ( Untrusted) -DFS enabled

module dmzstgdeploy '../../modules/Storage/storageAccounts/stg_dfsenabled.bicep' = if (untrustedstgpresent == true) {
  name: 'stgdeploydmz${env}${uniqueString(deployment().name)}'
  scope: resourceGroup(rg_malwarescanning)
  params: {
    allowSharedKeyAccess: true
    diagnosticWorkspaceId: law.outputs.lawop
    name: 'sauntrustedpolaris${env}'
    location: ukslocation
    largeFileSharesState: 'Disabled'
    storageAccountSku: 'Standard_ZRS'
    
    systemAssignedIdentity: true
    networkAcls: {
      resourceAccessRules: [
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
    allowCrossTenantReplication: true
    blobServices: {
      containers: [
        {
          name: 'uploads'
        }
      ]
      diagnosticWorkspaceId: law.outputs.lawop
    }
    queueServices: {
      queues: [
        {
          metadata: {
          }
          name: 'malwarescans'
        }
        {
          metadata: {}
          name: 'malwarescans-poison'
        }
      ]
    }
  }
}

module dmzstgdeployaddACL '../../modules/Storage/storageAccounts/stg_dfsenabled.bicep' = if (untrustedstgpresent == true) {
  name: 'stgdeploydmzaddacl${env}${uniqueString(deployment().name)}'
  scope: resourceGroup(rg_malwarescanning)
  dependsOn: [
    dmzstgdeploy
  ]
  params: {
    allowSharedKeyAccess: true
    diagnosticWorkspaceId: law.outputs.lawop
    name: 'sauntrustedpolaris${env}'
    location: ukslocation
    scanResultsEventGridTopicResourceId: eventgriduntrustedtopics.outputs.resourceId 
    largeFileSharesState: 'Disabled'
    storageAccountSku: 'Standard_ZRS'
    systemAssignedIdentity: true
    roleAssignments: [
      {
        principalIds: [
          eventgriduntrustedtopics.outputs.princpleid
        ]
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Storage Queue Data Message Sender'
      }
    ]
    networkAcls: {
      resourceAccessRules: [
        {
          action: 'Allow'
          id: eventgriduntrustedtopics.outputs.resourceId
      }
      ]
      bypass: 'AzureServices'
      virtualNetworkRules: [
        
      ]
      ipRules: [
        {
          value: '195.138.205.241'
          action: 'Allow'
        }
      ]
      defaultAction: 'Deny'
    }
    allowCrossTenantReplication: true
    blobServices: {
      containers: [
        {
          name: 'uploads'
        }
      ]
      diagnosticWorkspaceId: law.outputs.lawop
    }
    queueServices: {
      queues: [
        {
          metadata: {
          }
          name: 'malwarescans'

        }
        {
          metadata: {}
          name: 'malwarescans-poison'

        }
      ]
    }
  }
}

// DMZ Storage account ( Quarantine) - DFS enabled
module dmzstgQuarantine '../../modules/Storage/storageAccounts/stg.bicep' = {
  name: 'stgdeploydmzquarantine${env}${uniqueString(deployment().name)}'
  scope: resourceGroup(rg_malwarescanning)
  params: {
    diagnosticWorkspaceId: law.outputs.lawop
    allowSharedKeyAccess: true
    name: 'saquarantinepolaris${env}'
    location: ukslocation
    largeFileSharesState: 'Disabled'
    allowCrossTenantReplication: true
    storageAccountSku: 'Standard_ZRS'
    managementPolicyRules: [
      {
        enabled: true
        name: 'retention-policy'
        type: 'Lifecycle'
        definition: {
            actions: {
                baseBlob: {
                    delete: {
                        daysAfterModificationGreaterThan: 7
                    }
                }
            }
            filters: {
                blobTypes: [
                    'blockBlob'
                ]
            }
        }
    }
    ]
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
        }
      ]
      diagnosticWorkspaceId: law.outputs.lawop
    }
  }
}


//// Event-Grid

//untrusted event-grid 
module eventgriduntrustedtopics '../../modules/event-grid/topics/main.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-test-egtcom'
  scope: resourceGroup(rg_malwarescanning)
  dependsOn: [
    dmzstgdeploy
  ]
  params: {
    // Required parameters
    name: 'egt-untrusted-storage-malwarescan-${env}'
    // Non-required parameters
    diagnosticLogsRetentionInDays: 0
    diagnosticWorkspaceId: law.outputs.lawop
    diagnosticWorkspaceIdaudit: lawaudit.id
    eventSubscriptions: [
      {
        destination: {
          endpointType: 'StorageQueue'
          properties: {
            queueMessageTimeToLiveInSeconds: 86400
            queueName: 'malwarescans'
            resourceId: dmzstgdeploy.outputs.resourceId
          }
        }
        expirationTimeUtc: '2099-01-01T11:00:21.715Z'
        filter: {
          enableAdvancedFilteringOnArrays: true
        }
        name: 'send-malware-scans-to-untrusted-queue'
        retryPolicy: {
          eventTimeToLive: '120'
          maxDeliveryAttempts: 10
        }
      }

    ]
    publicNetworkAccess: 'Enabled'

  }
}


//// Sql Databases ////

// maintenanceConfiguration for db

module dbmaintenance '../../modules/Microsoft.Maintenance/maintenanceConfigurations/deploy.bicep' = {
  scope: resourceGroup(rg_sqlserver) 
  name: 'maintenancetasqldb${env}${uniqueString(deployment().name)}' 
  params: {
    name: 'sqldbmaintenancewindow01'
    location: ukslocation
    maintenanceWindow: {
      expirationDateTime: mainexpire
      recurEvery: mainrecur
      startDateTime: mainstart
      timeZone: maintimezone
      duration: mainduration
    }
    maintenanceScope: 'SQLManagedInstance'
  }
}

var uniquesqlpassword = '${administratorLoginPassword}${uniqueString(envshared)}'   


// module-Server - Local & AD SQL Database 

module sqldatabase '../../modules/Microsoft.Sql/servers/deploy.bicep' = {
  scope: resourceGroup(rg_sqlserver)
  name: 'ahsqldb${env}${uniqueString(deployment().name)}'
  params: {
     name: 'sql-server-spring-polaris-${env}-${ukslocation}'
     administratorLogin: administratorLogin
     administratorLoginPassword: uniquesqlpassword
    administrators: {
      administratorType: 'ActiveDirectory'
      azureADOnlyAuthentication: false
      principalType: 'Group'
      login: adsqllogin
      sid: sidsql
      tenantid: tentantid
    }
    location: ukslocation
    weekylong: weekylong 
    monthlylong: monthlylong
    yearlyRetention: yearlyRetention
    publicNetworkAccess: 'Disabled'

    databases: [
      {
        diagnosticWorkspaceId: law.outputs.lawop
        diagnosticWorkspaceIdaudit: lawaudit.id
        autoPauseDelay: 60
        name: 'sql-db-spring-polaris-${env}-${ukslocation}'
        serverName: 'sql-server-spring-polaris-${env}-${ukslocation}' 
        skuCapacity: skuCapacity
        skuName : skuName
        zoneRedundant: zoneRedundant
        maintenanceConfigurationId: '/subscriptions/${subscriptionid}/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_UKSouth_DB_2' 
        requestedBackupStorageRedundancy: requestedBackupStorageRedundancy
      }
    ]  
  }
}


//// Automation Account ////

module springautomation '../../modules/Microsoft.Automation/automationAccounts/deploy.bicep' = {
  scope: resourceGroup(rgautomation) 
  name: '${uniqueString(deployment().name)}-automation'
  params: {
    name: 'automation-polaris-${env}-${ukslocation}'
    location: ukslocation
    diagnosticWorkspaceId: law.outputs.lawop
    diagnosticWorkspaceIdAudit: lawaudit.id
    systemAssignedIdentity: true
    publicNetworkAccess: 'Disabled'
    runbooks: [
      {
        description: '${env} runbook'
        
        name: '${env}Runbook'
        type: 'PowerShell'
        uri: 'https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/quickstarts/microsoft.automation/101-automation/scripts/AzureAutomationTutorial.ps1'
        version: '1.0.0.0'
      }
    ]
    schedules: [
      {
        advancedSchedule: {}
        expiryTime: '9999-12-31T13:00'
        frequency: 'Day'
        interval: 1
        name: '${env}Runbook'
        startTime: automationstartTime

        timeZone: 'Europe/Berlin'
      }
    ]
    jobSchedules: [
      {
        runbookName: '${env}Runbook'
        scheduleName: '${env}Runbook'
      }
    ]
  }
}


//// Azure Cache for Redis ////

module rediscache '../../modules/Microsoft.Cache/redis/deploy.bicep' = {
  scope: resourceGroup(rg_rediscache) 
  name: '${uniqueString(deployment().name)}-rediscache'
  params: {
    name: 'redis-polaris-${env}-${ukslocation}'
    diagnosticWorkspaceId: lawaudit.id
    diagnosticWorkspaceIdmetric: law.outputs.lawop
    publicNetworkAccess: 'Disabled'
    
  }
}

/////////////////////////////
//// Resource Monitoring ////
/////////////////////////////

module foundationmonitor 'polaris-foundation-monitoring.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-monitor'
  params: {
    env:  env
    envshared: envshared
    rg_shared_monitoring: rg_shared_monitoring 
    rg_sqlserver: rg_sqlserver
    sharedmonitorsubscription: sharedmonitorsubscription 
    sqldatabase: sqldatabase.outputs.databaseresourceid
    ukslocation: ukslocation
  }
}
