////Needs work, having location issues////

//// Paramaters

param springCloudInstanceName string
param appname string
param location string = 'uksouth'

//// App Deployment

resource springCloudInstance 'Microsoft.AppPlatform/Spring@2022-09-01-preview' = {
  name: springCloudInstanceName
}

resource Spring_App_Default 'Microsoft.AppPlatform/Spring/apps@2022-09-01-preview' = {
  parent: springCloudInstance
  name: appname
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

resource apring_app_deployment 'Microsoft.AppPlatform/Spring/apps/deployments@2022-09-01-preview' = {
  parent: Spring_App_Default
  name: 'default'
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
      terminationGracePeriodSeconds: 90
      startupProbe: {
        disableProbe: true
      }
      livenessProbe: {
        disableProbe: false
        failureThreshold: 24
        initialDelaySeconds: 60
        periodSeconds: 10
        successThreshold: 1
        timeoutSeconds: 1
        probeAction: {
          type: 'TCPSocketAction'
        }
      }
      readinessProbe: {
        disableProbe: false
        failureThreshold: 3
        initialDelaySeconds: 0
        periodSeconds: 10
        successThreshold: 1
        timeoutSeconds: 1
        probeAction: {
          type:'TCPSocketAction'
        }
      }
    }
    active: true
     source: {
      relativePath: '<default>'
      type: 'Jar'
     }
  }
}
