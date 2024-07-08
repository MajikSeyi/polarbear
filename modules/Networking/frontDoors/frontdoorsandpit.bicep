//// Param ////hared_
param profiles_afd_name string // = 'afd-shared-production'
param privateLinkServices_pl_springapps_polaris_uat_externalid string  //'/subscriptions/f00e932c-2dc9-4eed-83ab-28bee4d9dbb3/resourceGroups/rg-virtual-networking/providers/Microsoft.Network/privateLinkServices/pl-springapps-polaris-uat'

//// Deployment ////
resource profiles_afd 'Microsoft.Cdn/profiles@2022-11-01-preview' = {
  name: profiles_afd_name
  location: 'Global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    originResponseTimeoutSeconds: 60
    extendedProperties: {
    }
  }
}

resource profiles_afd_uatname_polaris_uat 'Microsoft.Cdn/profiles/afdendpoints@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat'
  location: 'Global'
  properties: {
    enabledState: 'Enabled'
  }
}

///// Custom Domain ///// 

resource profiles_afd_uatname_uat_id_reedinpartnership_co_uk 'Microsoft.Cdn/profiles/customdomains@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'uat-id-reedinpartnership-co-uk'
  properties: {
    hostName: 'uat.id.reedinpartnership.co.uk'
    tlsSettings: {
      certificateType: 'ManagedCertificate'
      minimumTlsVersion: 'TLS12'
    }
  }
}

resource profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk 'Microsoft.Cdn/profiles/customdomains@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'uat-polaris-reedinpartnership-co-uk'
  properties: {
    hostName: 'uat.polaris.reedinpartnership.co.uk'
    tlsSettings: {
      certificateType: 'ManagedCertificate'
      minimumTlsVersion: 'TLS12'
    }
  }
}


///// Origin Groups /////

resource profiles_afd_uatname_polaris_uat_adb2c_custom_ui_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-adb2c-custom-ui-origin-group'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
    healthProbeSettings: {
      probePath: '/'
      probeRequestType: 'HEAD'
      probeProtocol: 'Http'
      probeIntervalInSeconds: 100
    }
    sessionAffinityState: 'Disabled'
  }
}

resource profiles_afd_uatname_polaris_uat_adb2c_tenant_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-adb2c-tenant-origin-group'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
    healthProbeSettings: {
      probePath: '/'
      probeRequestType: 'HEAD'
      probeProtocol: 'Http'
      probeIntervalInSeconds: 100
    }
    sessionAffinityState: 'Disabled'
  }
}

resource profiles_afd_uatname_polaris_uat_frontend_origingroup 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-frontend-origingroup'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
    healthProbeSettings: {
      probePath: '/'
      probeRequestType: 'HEAD'
      probeProtocol: 'Https'
      probeIntervalInSeconds: 100
    }
    sessionAffinityState: 'Disabled'
  }
}

resource profiles_afd_uatname_polaris_uat_spring_users_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-spring-users-origin-group'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
    healthProbeSettings: {
      probePath: '/'
      probeRequestType: 'HEAD'
      probeProtocol: 'Http'
      probeIntervalInSeconds: 240
    }
    sessionAffinityState: 'Disabled'
  }
}

resource profiles_afd_courses_uat_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-spring-courses-origin-group'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
    healthProbeSettings: {
      probePath: '/'
      probeRequestType: 'HEAD'
      probeProtocol: 'Http'
      probeIntervalInSeconds: 240
    }
    sessionAffinityState: 'Disabled'
  }
}

resource profiles_afd_uat_participants_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-spring-participants-origin-group'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
    healthProbeSettings: {
      probePath: '/'
      probeRequestType: 'HEAD'
      probeProtocol: 'Http'
      probeIntervalInSeconds: 240
    }
    sessionAffinityState: 'Disabled'
  }
}

resource profiles_afd_uat_staticdata_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-spring-staticdata-origin-group'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
    healthProbeSettings: {
      probePath: '/'
      probeRequestType: 'HEAD'
      probeProtocol: 'Http'
      probeIntervalInSeconds: 240
    }
    sessionAffinityState: 'Disabled'
  }
}

resource profiles_afd_uat_directus_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-spring-directus-origin-group'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
    healthProbeSettings: {
      probePath: '/'
      probeRequestType: 'HEAD'
      probeProtocol: 'Http'
      probeIntervalInSeconds: 240
    }
    sessionAffinityState: 'Disabled'
  }
}

///// Origins /////

resource profiles_afd_uatname_polaris_uat_adb2c_custom_ui_origin_group_polaris_uat_adb2c_custom_ui_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat_adb2c_custom_ui_origin_group
  name: 'polaris-uat-adb2c-custom-ui-origin'
  properties: {
    hostName: 'witty-stone-01ed44603.2.azurestaticapps.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'witty-stone-01ed44603.2.azurestaticapps.net'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_uatname_polaris_uat_adb2c_tenant_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat_adb2c_tenant_origin_group
  name: 'polaris-uat-adb2c-tenant-origin'
  properties: {
    hostName: 'rinppolarisuat.b2clogin.com'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'rinppolarisuat.b2clogin.com'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_uatname_frontend_polaris_uat_frontend_swa_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat_frontend_origingroup
  name: 'polaris-uat-frontend-swa-origin'
  properties: {
    hostName: 'witty-stone-01ed44603.2.azurestaticapps.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'witty-stone-01ed44603.2.azurestaticapps.net'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_uatname_polaris_uat_spring_users_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat_spring_users_origin_group
  name: 'polaris-uat-spring-users-origin'
  properties: {
    hostName: 'spring-polaris-uat-uksouth-user-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-uat-uksouth-user-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_uat_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_uat_courses_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_courses_uat_origin_group
  name: 'polaris-uat-spring-courses-origin'
  properties: {
    hostName: 'spring-polaris-uat-uksouth-course-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-uat-uksouth-course-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_uat_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_uat_participants_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_uat_participants_origin_group
  name: 'polaris-uat-spring-participants-origin'
  properties: {
    hostName: 'spring-polaris-uat-uksouth-participant-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-uat-uksouth-participant-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_uat_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_uat_staticdata_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_uat_staticdata_origin_group
  name: 'polaris-uat-spring-staticdata-origin'
  properties: {
    hostName: 'spring-polaris-uat-uksouth-static-data-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-uat-uksouth-static-data-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_uat_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_uat_directus_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_uat_directus_origin_group
  name: 'polaris-uat-spring-directus-origin'
  properties: {
    hostName: 'spring-polaris-uat-uksouth-directus-management-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-uat-uksouth-directus-management-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_uat_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}



///// Security Policy /////
resource profiles_afd_uatname_polaris_uat_security_policy 'Microsoft.Cdn/profiles/securitypolicies@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-security-policy'
  properties: {
    parameters: {
      wafPolicy: {
        id: frontdoorwebapplicationfirewallpolicies_wafpolarisuat.id
      }
      associations: [
        {
          domains: [
            {
              id: profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk.id
            }
          ]
          patternsToMatch: [
            '/*'
          ]
        }
      ]
      type: 'WebApplicationFirewall'
    }
  }
}


///// Routes /////

resource profiles_afd_uatname_polaris_uat_default_route 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat
  name: 'default-route'
  properties: {
    cacheConfiguration: {
      compressionSettings: {
        isCompressionEnabled: true
        contentTypesToCompress: [
          'application/eot'
          'application/font'
          'application/font-sfnt'
          'application/javascript'
          'application/json'
          'application/opentype'
          'application/otf'
          'application/pkcs7-mime'
          'application/truetype'
          'application/ttf'
          'application/vnd.ms-fontobject'
          'application/xhtml+xml'
          'application/xml'
          'application/xml+rss'
          'application/x-font-opentype'
          'application/x-font-truetype'
          'application/x-font-ttf'
          'application/x-httpd-cgi'
          'application/x-javascript'
          'application/x-mpegurl'
          'application/x-opentype'
          'application/x-otf'
          'application/x-perl'
          'application/x-ttf'
          'font/eot'
          'font/ttf'
          'font/otf'
          'font/opentype'
          'image/svg+xml'
          'text/css'
          'text/csv'
          'text/html'
          'text/javascript'
          'text/js'
          'text/plain'
          'text/richtext'
          'text/tab-separated-values'
          'text/xml'
          'text/x-script'
          'text/x-component'
          'text/x-java-source'
        ]
      }
      queryStringCachingBehavior: 'UseQueryString'
    }
    customDomains: [
      {
        id: profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_uatname_polaris_uat_frontend_origingroup.id
    }
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_uatname_polaris_uat_identity_adb2c_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat
  name: 'identity-adb2c'
  properties: {
    customDomains: [
      {
        id: profiles_afd_uatname_uat_id_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_uatname_polaris_uat_adb2c_tenant_origin_group.id
    }
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_uatname_polaris_uat_identity_adb2c_custom_ui_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat
  name: 'identity-adb2c-custom-ui'
  properties: {
    cacheConfiguration: {
      compressionSettings: {
        isCompressionEnabled: true
        contentTypesToCompress: [
          'application/eot'
          'application/font'
          'application/font-sfnt'
          'application/javascript'
          'application/json'
          'application/opentype'
          'application/otf'
          'application/pkcs7-mime'
          'application/truetype'
          'application/ttf'
          'application/vnd.ms-fontobject'
          'application/xhtml+xml'
          'application/xml'
          'application/xml+rss'
          'application/x-font-opentype'
          'application/x-font-truetype'
          'application/x-font-ttf'
          'application/x-httpd-cgi'
          'application/x-javascript'
          'application/x-mpegurl'
          'application/x-opentype'
          'application/x-otf'
          'application/x-perl'
          'application/x-ttf'
          'font/eot'
          'font/ttf'
          'font/otf'
          'font/opentype'
          'image/svg+xml'
          'text/css'
          'text/csv'
          'text/html'
          'text/javascript'
          'text/js'
          'text/plain'
          'text/richtext'
          'text/tab-separated-values'
          'text/xml'
          'text/x-script'
          'text/x-component'
          'text/x-java-source'
        ]
      }
      queryStringCachingBehavior: 'IgnoreQueryString'
    }
    customDomains: [
      {
        id: profiles_afd_uatname_uat_id_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_uatname_polaris_uat_adb2c_custom_ui_origin_group.id
    }
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/reedinpartnership/ui/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_uatname_polaris_uat_services_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat
  name: 'services-users'
  properties: {
    customDomains: [
      {
        id: profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_uatname_polaris_uat_spring_users_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/users/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_uatname_polaris_uat_courses_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat
  name: 'services-courses'
  properties: {
    customDomains: [
      {
        id: profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_courses_uat_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/courses/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_uatname_polaris_uat_participants_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat
  name: 'services-participants'
  properties: {
    customDomains: [
      {
        id: profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_uat_participants_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/participants/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_uatname_polaris_uat_staticdata_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat
  name: 'services-staticdata'
  properties: {
    customDomains: [
      {
        id: profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_uat_staticdata_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/staticdata/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_uatname_polaris_uat_directus_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat
  name: 'services-directus'
  properties: {
    customDomains: [
      {
        id: profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_uat_directus_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/directus/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}




//// WAF deployment ////

// WAF Param // 
param waf_uat_name string

param allowqualysscanuat array

param allowripsupplychainuat array

// WAF uat //


resource frontdoorwebapplicationfirewallpolicies_wafpolarisuat 'Microsoft.Network/frontdoorwebapplicationfirewallpolicies@2022-05-01' = {
  name: waf_uat_name
  location: 'Global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    policySettings: {
      enabledState: 'Enabled'
      mode: 'Prevention'
      customBlockResponseStatusCode: 403
      customBlockResponseBody: 'WW91IGFyZSBub3QgYXV0aG9yaXNlZCB0byBhY2Nlc3MgdGhpcyByZXNvdXJjZSwgcGxlYXNlIGNvbnRhY3QgSVQgdG8gcmVxdWVzdCBhY2Nlc3Mu'

      requestBodyCheck: 'Enabled'
    }
    customRules: {
      rules: [
        {
          name: 'denyall'
          enabledState: 'Enabled'
          priority: 1000
          ruleType: 'MatchRule'
          rateLimitDurationInMinutes: 1
          rateLimitThreshold: 100
          matchConditions: [
            {
              matchVariable: 'RequestUri'
              operator: 'Any'
              negateCondition: false
              matchValue: []
              transforms: []
            }
          ]
          action: 'Block'
        }
        {
          name: 'allowonprem'
          enabledState: 'Enabled'
          priority: 100
          ruleType: 'MatchRule'
          rateLimitDurationInMinutes: 1
          rateLimitThreshold: 100
          matchConditions: [
            {
              matchVariable: 'SocketAddr'
              operator: 'IPMatch'
              negateCondition: false
              matchValue: [
                '195.138.205.241'
              ]
              transforms: []
            }
          ]
          action: 'Allow'
        }
        {
          name: 'allowqualysscan'
          enabledState: 'Enabled'
          priority: 130
          ruleType: 'MatchRule'
          rateLimitDurationInMinutes: 1
          rateLimitThreshold: 100
          matchConditions: [
            {
              matchVariable: 'SocketAddr'
              operator: 'IPMatch'
              negateCondition: false
              matchValue: allowqualysscanuat
              transforms: []
            }
          ]
          action: 'Allow'
        }
        {
          name: 'allowripsupplychain'
          enabledState: 'Enabled'
          priority: 150
          ruleType: 'MatchRule'
          rateLimitDurationInMinutes: 1
          rateLimitThreshold: 100
          matchConditions: [
            {
              matchVariable: 'SocketAddr'
              operator: 'IPMatch'
              negateCondition: false
              matchValue: allowripsupplychainuat
              transforms: []
            }
          ]
          action: 'Allow'
        }
      ]
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'Microsoft_DefaultRuleSet'
          ruleSetVersion: '2.0'
          ruleSetAction: 'Block'
          ruleGroupOverrides: [
            {
              ruleGroupName: 'SQLI'
              rules: [
                {
                  ruleId: '942440'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
                {
                  ruleId: '942430'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
                {
                  ruleId: '942110'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'MS-ThreatIntel-CVEs'
              rules: [
                {
                  ruleId: '99001016'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
                {
                  ruleId: '99001015'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
                {
                  ruleId: '99001014'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'MS-ThreatIntel-WebShells'
              rules: [
                {
                  ruleId: '99005006'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
              ]
              exclusions: []
            }
          ]
          exclusions: []
        }
        {
          ruleSetType: 'Microsoft_BotManagerRuleSet'
          ruleSetVersion: '1.0'
          ruleGroupOverrides: []
          exclusions: []
        }
      ]
    }
  }
}

//// LAW //// 

@description('Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.')
@minValue(0)
@maxValue(365)
param diagnosticLogsRetentionInDays int = 365

@description('Optional. Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
param diagnosticStorageAccountId string = ''

@description('Optional. Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
param diagnosticWorkspaceId string = ''

@description('Optional. Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
param diagnosticWorkspaceIdAudit string = ''

@description('Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.')
param diagnosticEventHubAuthorizationRuleId string = ''

@description('Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
param diagnosticEventHubName string = ''

@description('Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource.')
@allowed([
  'allLogs'
  'FrontdoorAccessLog'
  'FrontdoorWebApplicationFirewallLog'
])
param diagnosticLogCategoriesToEnable array = [
  'allLogs'
]

@description('Optional. The name of metrics that will be streamed.')
@allowed([
  'AllMetrics'
])
param metricsToEnable array = [
  'AllMetrics'
]

var diagnosticsLogsSpecified = [for category in filter(diagnosticLogCategoriesToEnable, item => item != 'allLogs'): {
  category: category
  enabled: true
  retentionPolicy: {
    enabled: true
    days: diagnosticLogsRetentionInDays
  }
}]

var diagnosticsLogs = contains(diagnosticLogCategoriesToEnable, 'allLogs') ? [
  {
    categoryGroup: 'allLogs'
    enabled: true
    retentionPolicy: {
      enabled: true
      days: diagnosticLogsRetentionInDays
    }
  }
] : diagnosticsLogsSpecified

var diagnosticsMetrics = [for metric in metricsToEnable: {
  category: metric
  timeGrain: null
  enabled: true
  retentionPolicy: {
    enabled: true
    days: diagnosticLogsRetentionInDays
  }
}]

resource frontDoor_diagnosticSettingName 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (!empty(diagnosticStorageAccountId) || !empty(diagnosticWorkspaceId) || !empty(diagnosticEventHubAuthorizationRuleId) || !empty(diagnosticEventHubName)) {
  name: '${profiles_afd.name}-diagnosticSettings'
  properties: {
    storageAccountId: empty(diagnosticStorageAccountId) ? null : diagnosticStorageAccountId
    workspaceId: empty(diagnosticWorkspaceId) ? null : diagnosticWorkspaceId
    eventHubAuthorizationRuleId: empty(diagnosticEventHubAuthorizationRuleId) ? null : diagnosticEventHubAuthorizationRuleId
    eventHubName: empty(diagnosticEventHubName) ? null : diagnosticEventHubName
    metrics: empty(diagnosticStorageAccountId) && empty(diagnosticWorkspaceId) && empty(diagnosticEventHubAuthorizationRuleId) && empty(diagnosticEventHubName) ? null : diagnosticsMetrics
    logs: empty(diagnosticStorageAccountId) && empty(diagnosticWorkspaceId) && empty(diagnosticEventHubAuthorizationRuleId) && empty(diagnosticEventHubName) ? null : diagnosticsLogs
  }
  scope: profiles_afd
}

resource frontDoor_diagnosticSettingName_audit 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (!empty(diagnosticStorageAccountId) || !empty(diagnosticWorkspaceIdAudit) || !empty(diagnosticEventHubAuthorizationRuleId) || !empty(diagnosticEventHubName)) {
  name: '${profiles_afd.name}-diagnosticSettings-audit'
  properties: {
    storageAccountId: empty(diagnosticStorageAccountId) ? null : diagnosticStorageAccountId
    workspaceId: empty(diagnosticWorkspaceIdAudit) ? null : diagnosticWorkspaceIdAudit
    eventHubAuthorizationRuleId: empty(diagnosticEventHubAuthorizationRuleId) ? null : diagnosticEventHubAuthorizationRuleId
    eventHubName: empty(diagnosticEventHubName) ? null : diagnosticEventHubName
    logs: [
      {
        category: 'FrontDoorWebApplicationFirewallLog'
        categoryGroup: null
        enabled: true
        retentionPolicy: {
          days: 30
          enabled: false
        }
      }
    ]
  }
  scope: profiles_afd
}
