@description('The instance name of the Azure Spring Cloud resource')
param springCloudInstanceName string

@description('Resource to be set to "true" for all apps to be ignored. "False" will run the app. ')
param resourceExists bool 

@description('Optional. The name of the diagnostic setting, if deployed.')
param diagnosticSettingsName string = '${springCloudInstanceName}-diagnosticSettingsops'

@description('The resourceID of the Azure Spring Cloud App Subnet')
param springCloudAppSubnetID string

@description('The resourceID of the Azure Spring Cloud Runtime Subnet')
param springCloudRuntimeSubnetID string

@description('Comma-separated list of IP address ranges in CIDR format. The IP ranges are reserved to host underlying Azure Spring Cloud infrastructure, which should be 3 at least /16 unused IP ranges, must not overlap with any Subnet IP ranges')
param springCloudServiceCidrs string

@description('runtime resourceGroup')
param RuntimeNetworkResourceGroup string

@description('applicatiob resourceGroup')
param appNetworkResourceGroup string

param location string

@description('App name to be deployed')
param calendarservice string

param env string

param ukslocation string

param rg_shared_monitoring string

param sharedmonitorsubscription string

param sharedenv string


param appconfig_endpoint string

param coursename string

param participantename string

param communicationname string

param usernameservice string

param directusmanagement string

param documentsservice string

param recruitmentservice string

param zoneRedundant bool

@description('Optional. Array of role assignment objects that contain the \'roleDefinitionIdOrName\' and \'principalId\' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'.')
param roleAssignments array = []

module springcloud_roleAssignments '../.bicep/nested_roleAssignments.bicep' = [for (roleAssignment, index) in roleAssignments: {
  name: '${uniqueString(deployment().name, location)}-AutoAccount-Rbac-${index}'
  params: {
    description: contains(roleAssignment, 'description') ? roleAssignment.description : ''
    principalIds: roleAssignment.principalIds
    principalType: contains(roleAssignment, 'principalType') ? roleAssignment.principalType : ''
    roleDefinitionIdOrName: roleAssignment.roleDefinitionIdOrName
    condition: contains(roleAssignment, 'condition') ? roleAssignment.condition : ''
    delegatedManagedIdentityResourceId: contains(roleAssignment, 'delegatedManagedIdentityResourceId') ? roleAssignment.delegatedManagedIdentityResourceId : ''
    resourceId: springCloudInstance.id
  }
}]



resource springCloudInstance 'Microsoft.AppPlatform/Spring@2022-09-01-preview' = {
  name: springCloudInstanceName
  location: location
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
  properties: {
    zoneRedundant: zoneRedundant
    vnetAddons: {
      logStreamPublicEndpoint: false
    }
    networkProfile: {
      serviceCidr: springCloudServiceCidrs
      serviceRuntimeSubnetId: springCloudRuntimeSubnetID
      appSubnetId: springCloudAppSubnetID
      serviceRuntimeNetworkResourceGroup: RuntimeNetworkResourceGroup
      appNetworkResourceGroup: appNetworkResourceGroup
      outboundType: 'userDefinedRouting'
    }
  }
}

output serviceid string = springCloudInstance.properties.serviceId
output springid string = springCloudInstance.id


// App Deployments- calendar-service
resource Spring_spring_polaris_name_calendar 'Microsoft.AppPlatform/Spring/apps@2022-09-01-preview' = if (!resourceExists) {
  parent: springCloudInstance
  name: calendarservice
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    addonConfigs: {
      applicationConfigurationService: {
      }
      serviceRegistry: {
      }
    }
    public: true
    httpsOnly: false
    temporaryDisk: {
      sizeInGB: 5
      mountPath: '/tmp'
    }
    persistentDisk: {
      sizeInGB: 0
      mountPath: '/persistent'
    }
    enableEndToEndTLS: false 
    vnetAddons: {
      publicEndpoint: false
    }
    ingressSettings: {
      readTimeoutInSeconds: 300
      sendTimeoutInSeconds: 60
      sessionCookieMaxAge: 0
      sessionAffinity: 'None'
      backendProtocol: 'Default'
    }
    
  }
}



resource Spring_spring_polaris_name_Calendar_deploy 'Microsoft.AppPlatform/Spring/apps/deployments@2022-09-01-preview' = if (!resourceExists) {
  parent: Spring_spring_polaris_name_calendar
  name: 'calendar'
  sku: {
    name: 'S0'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    deploymentSettings: {
      resourceRequests: {
        cpu: '1'
        memory: '1Gi'
      }
      environmentVariables: {
        AZURE_APPCONFIGURATION_ENDPOINT: appconfig_endpoint
        SPRING_PROFILES_ACTIVE: 'cloud'
        MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE: 'health'
      }
      terminationGracePeriodSeconds: 90
      startupProbe: {
        disableProbe: true
      }
      livenessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 300
        periodSeconds: 10
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type: 'TCPSocketAction'
        }
      }
      readinessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 0
        periodSeconds: 5
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type:'TCPSocketAction'
        }
      }
    }
    active: true
     source: {
      relativePath: '<default>'
      type: 'Jar'
      jvmOptions: '-XX:InitialRAMPercentage=30.0 -XX:MaxRAMPercentage=30.0 -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=192M -XX:ReservedCodeCacheSize=240M -Xss512K'
      runtimeVersion: 'Java_17'
     }
  }
}

// App Deployments-course-service
resource Spring_App_course_service 'Microsoft.AppPlatform/Spring/apps@2022-09-01-preview' = if (!resourceExists) {
  parent: springCloudInstance
  name: coursename
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    addonConfigs: {
      applicationConfigurationService: {
      }
      serviceRegistry: {
      }
    }
    public: true
    httpsOnly: false
    temporaryDisk: {
      sizeInGB: 5
      mountPath: '/tmp'
    }
    persistentDisk: {
      sizeInGB: 0
      mountPath: '/persistent'
    }
    enableEndToEndTLS: false
    vnetAddons: {
      publicEndpoint: false
    }
    ingressSettings: {
      readTimeoutInSeconds: 300
      sendTimeoutInSeconds: 60
      sessionCookieMaxAge: 0
      sessionAffinity: 'None'
      backendProtocol: 'Default'
    }
    
  }
}

resource Spring_App_course_service_deploy 'Microsoft.AppPlatform/Spring/apps/deployments@2022-12-01' = if (!resourceExists) {
  parent: Spring_App_course_service
  name: 'course'
  sku: {
    name: 'S0'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    deploymentSettings: {
      resourceRequests: {
        cpu: '1'
        memory: '1Gi'
      }
      environmentVariables: {
        AZURE_APPCONFIGURATION_ENDPOINT: appconfig_endpoint
        SPRING_PROFILES_ACTIVE: 'cloud'
        MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE: 'health'
      }
      terminationGracePeriodSeconds: 90
      startupProbe: {
        disableProbe: true
      }
      livenessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 300
        periodSeconds: 10
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type: 'TCPSocketAction'
        }
      }
      readinessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 0
        periodSeconds: 5
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type:'TCPSocketAction'
        }
      }
    }
    active: true
     source: {
      relativePath: '<default>'
      type: 'Jar'
      jvmOptions: '-XX:InitialRAMPercentage=30.0 -XX:MaxRAMPercentage=30.0 -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=192M -XX:ReservedCodeCacheSize=240M -Xss512K'
      runtimeVersion: 'Java_17'

     }
  }
}

// App Deployments-participant-service
resource Spring_App_participant_service 'Microsoft.AppPlatform/Spring/apps@2022-09-01-preview' = if (!resourceExists) {
  parent: springCloudInstance
  name: participantename
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    addonConfigs: {
      applicationConfigurationService: {
      }
      serviceRegistry: {
      }
    }
    public: true
    httpsOnly: false
    temporaryDisk: {
      sizeInGB: 5
      mountPath: '/tmp'
    }
    persistentDisk: {
      sizeInGB: 0
      mountPath: '/persistent'
    }
    enableEndToEndTLS: false
    vnetAddons: {
      publicEndpoint: false
    }
    ingressSettings: {
      readTimeoutInSeconds: 300
      sendTimeoutInSeconds: 60
      sessionCookieMaxAge: 0
      sessionAffinity: 'None'
      backendProtocol: 'Default'
    }
    
  }
}

resource Spring_App_participant_service_deploy 'Microsoft.AppPlatform/Spring/apps/deployments@2022-12-01' = if (!resourceExists) {
  parent: Spring_App_participant_service
  name: 'participant'
  sku: {
    name: 'S0'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    deploymentSettings: {
      resourceRequests: {
        cpu: '1'
        memory: '1Gi'
      }
      environmentVariables: {
        AZURE_APPCONFIGURATION_ENDPOINT: appconfig_endpoint
        SPRING_PROFILES_ACTIVE: 'cloud'
        MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE: 'health'
      }
      terminationGracePeriodSeconds: 90
      startupProbe: {
        disableProbe: true
      }
      livenessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 300
        periodSeconds: 10
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type: 'TCPSocketAction'
        }
      }
      readinessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 0
        periodSeconds: 5
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type:'TCPSocketAction'
        }
      }
    }
    active: true
     source: {
      relativePath: '<default>'
      type: 'Jar'
      jvmOptions: '-XX:InitialRAMPercentage=30.0 -XX:MaxRAMPercentage=30.0 -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=192M -XX:ReservedCodeCacheSize=240M -Xss512K'
      runtimeVersion: 'Java_17'

     }
  }
}


// App Deployments-communication-service  
resource Spring_communication_service 'Microsoft.AppPlatform/Spring/apps@2022-09-01-preview' = if (!resourceExists) {
  parent: springCloudInstance
  name: communicationname
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    addonConfigs: {
      applicationConfigurationService: {
      }
      serviceRegistry: {
      }
    }
    public: true
    httpsOnly: false
    temporaryDisk: {
      sizeInGB: 5
      mountPath: '/tmp'
    }
    persistentDisk: {
      sizeInGB: 0
      mountPath: '/persistent'
    }
    enableEndToEndTLS: false
    vnetAddons: {
      publicEndpoint: false
    }
    ingressSettings: {
      readTimeoutInSeconds: 300
      sendTimeoutInSeconds: 60
      sessionCookieMaxAge: 0
      sessionAffinity: 'None'
      backendProtocol: 'Default'
    }
    
  }
}

resource Spring_communication_service_deploy 'Microsoft.AppPlatform/Spring/apps/deployments@2022-12-01' = if (!resourceExists) {
  parent: Spring_communication_service
  name: 'communication'
  sku: {
    name: 'S0'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    deploymentSettings: {
      resourceRequests: {
        cpu: '1'
        memory: '1Gi'
      }
      environmentVariables: {
        AZURE_APPCONFIGURATION_ENDPOINT: appconfig_endpoint
        SPRING_PROFILES_ACTIVE: 'cloud'
        MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE: 'health'
      }
      terminationGracePeriodSeconds: 90
      startupProbe: {
        disableProbe: true
      }
      livenessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 300
        periodSeconds: 10
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type: 'TCPSocketAction'
        }
      }
      readinessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 0
        periodSeconds: 5
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type:'TCPSocketAction'
        }
      }
    }
    active: true
     source: {
      relativePath: '<default>'
      type: 'Jar'
      jvmOptions: '-XX:InitialRAMPercentage=30.0 -XX:MaxRAMPercentage=30.0 -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=192M -XX:ReservedCodeCacheSize=240M -Xss512K'
      runtimeVersion: 'Java_17'

     }
  }
}

// App Deployments-user-service
resource Spring_user_service 'Microsoft.AppPlatform/Spring/apps@2022-09-01-preview' = if (!resourceExists) {
  parent: springCloudInstance
  name: usernameservice
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    addonConfigs: {
      applicationConfigurationService: {
      }
      serviceRegistry: {
      }
    }
    public: true
    httpsOnly: false
    temporaryDisk: {
      sizeInGB: 5
      mountPath: '/tmp'
    }
    persistentDisk: {
      sizeInGB: 0
      mountPath: '/persistent'
    }
    enableEndToEndTLS: false
    vnetAddons: {
      publicEndpoint: false
    }
    ingressSettings: {
      readTimeoutInSeconds: 300
      sendTimeoutInSeconds: 60
      sessionCookieMaxAge: 0
      sessionAffinity: 'None'
      backendProtocol: 'Default'
    }
    
  }
}

resource Spring_user_service_deploy 'Microsoft.AppPlatform/Spring/apps/deployments@2022-12-01' = if (!resourceExists) {
  parent: Spring_user_service
  name: 'user'
  sku: {
    name: 'S0'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    deploymentSettings: {
      resourceRequests: {
        cpu: '1'
        memory: '1Gi'
      }
      environmentVariables: {
        AZURE_APPCONFIGURATION_ENDPOINT: appconfig_endpoint
        SPRING_PROFILES_ACTIVE: 'cloud'
        MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE: 'health'
      }
      terminationGracePeriodSeconds: 90
      startupProbe: {
        disableProbe: true
      }
      livenessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 300
        periodSeconds: 10
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type: 'TCPSocketAction'
        }
      }
      readinessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 0
        periodSeconds: 5
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type:'TCPSocketAction'
        }
      }
    }
    active: true
     source: {
      relativePath: '<default>'
      type: 'Jar'
      jvmOptions: '-XX:InitialRAMPercentage=30.0 -XX:MaxRAMPercentage=30.0 -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=192M -XX:ReservedCodeCacheSize=240M -Xss512K'
      runtimeVersion: 'Java_17'

     }
  }
}

// App Deployments-directus-management-service
resource Spring_directus_management_service 'Microsoft.AppPlatform/Spring/apps@2022-09-01-preview' = if (!resourceExists) {
  parent: springCloudInstance
  name: directusmanagement
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    addonConfigs: {
      applicationConfigurationService: {
      }
      serviceRegistry: {
      }
    }
    public: true
    httpsOnly: false
    temporaryDisk: {
      sizeInGB: 5
      mountPath: '/tmp'
    }
    persistentDisk: {
      sizeInGB: 0
      mountPath: '/persistent'
    }
    enableEndToEndTLS: false
    vnetAddons: {
      publicEndpoint: false
    }
    ingressSettings: {
      readTimeoutInSeconds: 300
      sendTimeoutInSeconds: 60
      sessionCookieMaxAge: 0
      sessionAffinity: 'None'
      backendProtocol: 'Default'
    }
    
  }
}

resource Spring_directus_management_service_deploy 'Microsoft.AppPlatform/Spring/apps/deployments@2022-12-01' = if (!resourceExists) {
  parent: Spring_directus_management_service
  name: 'directusmanagement'
  sku: {
    name: 'S0'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    deploymentSettings: {
      resourceRequests: {
        cpu: '1'
        memory: '1Gi'
      }
      environmentVariables: {
        AZURE_APPCONFIGURATION_ENDPOINT: appconfig_endpoint
        SPRING_PROFILES_ACTIVE: 'cloud'
        MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE: 'health'
      }
      terminationGracePeriodSeconds: 90
      startupProbe: {
        disableProbe: true
      }
      livenessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 300
        periodSeconds: 10
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type: 'TCPSocketAction'
        }
      }
      readinessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 0
        periodSeconds: 5
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type:'TCPSocketAction'
        }
      }
    }
    active: true
     source: {
      relativePath: '<default>'
      jvmOptions: '-XX:InitialRAMPercentage=30.0 -XX:MaxRAMPercentage=30.0 -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=192M -XX:ReservedCodeCacheSize=240M -Xss512K'
      type: 'Jar'
      runtimeVersion: 'Java_17'

     }
  }
}

// App Deployments-documents-service
resource Spring_documents_service 'Microsoft.AppPlatform/Spring/apps@2022-09-01-preview' = if (!resourceExists) {
  parent: springCloudInstance
  name: documentsservice
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    addonConfigs: {
      applicationConfigurationService: {
      }
      serviceRegistry: {
      }
    }
    public: true
    httpsOnly: false
    temporaryDisk: {
      sizeInGB: 5
      mountPath: '/tmp'
    }
    persistentDisk: {
      sizeInGB: 0
      mountPath: '/persistent'
    }
    enableEndToEndTLS: false
    vnetAddons: {
      publicEndpoint: false
    }
    ingressSettings: {
      readTimeoutInSeconds: 300
      sendTimeoutInSeconds: 60
      sessionCookieMaxAge: 0
      sessionAffinity: 'None'
      backendProtocol: 'Default'
    }
    
  }
}

resource Spring_documents_service_deploy 'Microsoft.AppPlatform/Spring/apps/deployments@2022-12-01' = if (!resourceExists) {
  parent: Spring_documents_service
  name: 'document'
  sku: {
    name: 'S0'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    deploymentSettings: {
      resourceRequests: {
        cpu: '1'
        memory: '1Gi'
      }
      environmentVariables: {
        AZURE_APPCONFIGURATION_ENDPOINT: appconfig_endpoint
        SPRING_PROFILES_ACTIVE: 'cloud'
        MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE: 'health'
      }
      terminationGracePeriodSeconds: 90
      startupProbe: {
        disableProbe: true
      }
      livenessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 300
        periodSeconds: 10
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type: 'TCPSocketAction'
        }
      }
      readinessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 0
        periodSeconds: 5
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type:'TCPSocketAction'
        }
      }
    }
    active: true
     source: {
      relativePath: '<default>'
      jvmOptions: '-XX:InitialRAMPercentage=30.0 -XX:MaxRAMPercentage=30.0 -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=192M -XX:ReservedCodeCacheSize=240M -Xss512K'
      type: 'Jar'
      runtimeVersion: 'Java_17'

     }
  }
}

// App Deployments-documents-service
resource Spring_recruitment_service 'Microsoft.AppPlatform/Spring/apps@2022-09-01-preview' = if (!resourceExists) {
  parent: springCloudInstance
  name: recruitmentservice
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    addonConfigs: {
      applicationConfigurationService: {
      }
      serviceRegistry: {
      }
    }
    public: true
    httpsOnly: false
    temporaryDisk: {
      sizeInGB: 5
      mountPath: '/tmp'
    }
    persistentDisk: {
      sizeInGB: 0
      mountPath: '/persistent'
    }
    enableEndToEndTLS: false
    vnetAddons: {
      publicEndpoint: false
    }
    ingressSettings: {
      readTimeoutInSeconds: 300
      sendTimeoutInSeconds: 60
      sessionCookieMaxAge: 0
      sessionAffinity: 'None'
      backendProtocol: 'Default'
    }
    
  }
}

resource Spring_recruitment_service_deploy 'Microsoft.AppPlatform/Spring/apps/deployments@2022-12-01' = if (!resourceExists) {
  parent: Spring_recruitment_service
  name: 'recruitment'
  sku: {
    name: 'S0'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    deploymentSettings: {
      resourceRequests: {
        cpu: '1'
        memory: '1Gi'
      }
      environmentVariables: {
        AZURE_APPCONFIGURATION_ENDPOINT: appconfig_endpoint
        SPRING_PROFILES_ACTIVE: 'cloud'
        MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE: 'health'
      }
      terminationGracePeriodSeconds: 90
      startupProbe: {
        disableProbe: true
      }
      livenessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 300
        periodSeconds: 10
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type: 'TCPSocketAction'
        }
      }
      readinessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 0
        periodSeconds: 5
        successThreshold: 1
        timeoutSeconds: 3
        probeAction: {
          type:'TCPSocketAction'
        }
      }
    }
    active: true
     source: {
      relativePath: '<default>'
      jvmOptions: '-XX:InitialRAMPercentage=30.0 -XX:MaxRAMPercentage=30.0 -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=192M -XX:ReservedCodeCacheSize=240M -Xss512K'
      type: 'Jar'
      runtimeVersion: 'Java_17'

     }
  }
}





module law '../../../Shared-Services/Shared-Monitoring/shared-monitoring.bicep'  =  {
  scope: subscription(sharedmonitorsubscription)
  name: 'lawop${env}${uniqueString(deployment().name)}-01'
  params: {
    rg_shared_monitoring: rg_shared_monitoring 
    sharedenv: sharedenv
    sharedmonitorsubscription: sharedmonitorsubscription
    ukslocation: ukslocation
  }
}

resource springCloudDiagnostics 'microsoft.insights/diagnosticSettings@2017-05-01-preview' = {
  scope: springCloudInstance 
  name: diagnosticSettingsName
  properties: {
    workspaceId: law.outputs.lawop
    logs: [
      {
        category: 'ApplicationConsole'
        enabled: true
        retentionPolicy: {
          days: 30
          enabled: false
        }
      }
      {
        category: 'SystemLogs'
        enabled: true
        retentionPolicy: {
          days: 30
          enabled: false
        }
      }
      {
        category: 'IngressLogs'
        enabled: true
        retentionPolicy: {
          days: 30
          enabled: false
        }
      }
      {
        category: 'BuildLogs'
        enabled: true
        retentionPolicy: {
          days: 30
          enabled: false
        }
      }
      {
        category: 'ContainerEventLogs'
        enabled: true
        retentionPolicy: {
          days: 30
          enabled: false
        }
      }
    ]
    metrics: [
      {
        enabled: true
        category: 'AllMetrics'
        retentionPolicy: {
          days: 30
          enabled: false
        }
      }
    ]
  }
}

output app_calandar_service_principleid string = Spring_spring_polaris_name_calendar.identity.principalId
output app_communication_service_principleid string = Spring_communication_service.identity.principalId
output app_course_service_principleid string = Spring_App_course_service.identity.principalId
output app_directus_management_service_principleid string = Spring_directus_management_service.identity.principalId
output app_document_service_principleid string = Spring_documents_service.identity.principalId
output app_participant_service_principleid string = Spring_App_participant_service.identity.principalId
output app_recruitment_service_principleid string = Spring_recruitment_service.identity.principalId
output app_user_service_principleid string = Spring_user_service.identity.principalId


