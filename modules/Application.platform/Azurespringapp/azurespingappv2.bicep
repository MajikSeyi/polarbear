@description('The instance name of the Azure Spring Cloud resource')
param springCloudInstanceName string

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

param env string

param ukslocation string

param rg_shared_monitoring string

param sharedmonitorsubscription string

param sharedenv string

param polaris_host string

param polaris_db string

resource springCloudInstance 'Microsoft.AppPlatform/Spring@2022-09-01-preview' = {
  name: springCloudInstanceName
  location: location
  // tags: tags
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
  properties: {
    zoneRedundant: false
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

param resourceExists bool 

// App Deployments - AH TEst
resource Spring_directus_management_service 'Microsoft.AppPlatform/Spring/apps@2022-09-01-preview' = if (!resourceExists) {
  parent: springCloudInstance
  name: 'test-service-bicep'
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



resource Spring_directus_management_service_deploy 'Microsoft.AppPlatform/Spring/apps/deployments@2022-12-01' = if (!resourceExists){
  parent: Spring_directus_management_service
  name: 'test-service-bicep'
  sku: {
    name: 'S0'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    deploymentSettings: {
      resourceRequests: {
        cpu: '1'
        memory: '512Mi'
      }
      environmentVariables: {
        POLARIS_DB: polaris_db
        POLARIS_DB_PASSWORD: 'fkN4KkhdUdVJMFNJa55b'
        POLARIS_DB_USERNAME: 'directus-management-service-user'
        DIRECTUS_STATIC_TOKEN: '_XxfoX9w4uxQCbjimU3kDwFJQJbQY9Et'
        POLARIS_HOST: polaris_host
        POLARIS_PORT: '1433'
        POLARIS_JWT_SECRET: '79CsmDJsxx4t8FwJdfzyNEqu'
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
      relativePath: '12345678910'
      type: 'Jar'
      runtimeVersion: 'Java_17'
     }
  }
}

// App Deployments - AH TEst
resource Spring_bicep_management_service 'Microsoft.AppPlatform/Spring/apps@2022-09-01-preview' = if (!resourceExists) {
  parent: springCloudInstance
  name: 'test-service-bicep-v2'
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



resource Spring_biceptest_management_service_deploy 'Microsoft.AppPlatform/Spring/apps/deployments@2022-12-01' = if (!resourceExists){
  parent: Spring_bicep_management_service
  name: 'biceptest'
  sku: {
    name: 'S0'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    deploymentSettings: {
      resourceRequests: {
        cpu: '1'
        memory: '512Mi'
      }
      environmentVariables: {
        POLARIS_DB: polaris_db
        POLARIS_DB_PASSWORD: 'fkN4KkhdUdVJMFNJa55b'
        POLARIS_DB_USERNAME: 'directus-management-service-user'
        DIRECTUS_STATIC_TOKEN: '_XxfoX9w4uxQCbjimU3kDwFJQJbQY9Et'
        POLARIS_HOST: polaris_host
        POLARIS_PORT: '1433'
        POLARIS_JWT_SECRET: '79CsmDJsxx4t8FwJdfzyNEqu'
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
      runtimeVersion: 'Java_17'
     }
  }
}



module law '../../../Shared-Services/Shared-Monitoring/shared-monitoring.bicep' =  {
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
