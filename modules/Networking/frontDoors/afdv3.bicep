//// Param ////hared_
param profiles_afd_name string // = 'afd-shared-production'param privateLinkServices_pl_springapps_polaris_prod_externalid string  //'/subscriptions/f00e932c-2dc9-4eed-83ab-28bee4d9dbb3/resourceGroups/rg-virtual-networking/providers/Microsoft.Network/privateLinkServices/pl-springapps-polaris-test'
 
param privateLinkServices_pl_springapps_polaris_test_externalid string  //'/subscriptions/f00e932c-2dc9-4eed-83ab-28bee4d9dbb3/resourceGroups/rg-virtual-networking/providers/Microsoft.Network/privateLinkServices/pl-springapps-polaris-test'
param privateLinkServices_pl_springapps_polaris_uat_externalid string
param privateLinkServices_pl_springapps_polaris_trn_externalid string 
param privateLinkServices_pl_springapps_polaris_prod_externalid string

param wafpolaristestid string
param wafpolarisuatid string
param wafpolaristrnid string
param wafpolarisprodid string
// param frontdoorwebapplicationfirewallpolicies_wafpolaristest_externalid string //= '/subscriptions/e22eb6a5-6f38-4574-9b84-1c1dbe1c8b97/resourceGroups/rg-frontdoor/providers/Microsoft.Network/frontdoorwebapplicationfirewallpolicies/wafpolaristest'

//// Deployment ////
resource profiles_afd 'Microsoft.Cdn/profiles@2022-11-01-preview' = {
  name: profiles_afd_name
  location: 'Global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    originResponseTimeoutSeconds: 120
    extendedProperties: {
    }
  }
}



//AFD ENDPOINTS//

//TEST//
resource profiles_afd_testname_polaris_test 'Microsoft.Cdn/profiles/afdendpoints@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test'
  location: 'Global'
  properties: {
    enabledState: 'Enabled'
  }
}

//UAT//
resource profiles_afd_uatname_polaris_uat 'Microsoft.Cdn/profiles/afdendpoints@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat'
  location: 'Global'
  properties: {
    enabledState: 'Enabled'
  }
}

//TRAN//
resource profiles_afd_trnname_polaris_trn 'Microsoft.Cdn/profiles/afdendpoints@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn'
  location: 'Global'
  properties: {
    enabledState: 'Enabled'
  }
}

//PROD//
resource profiles_afd_prodname_polaris_prod 'Microsoft.Cdn/profiles/afdendpoints@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod'
  location: 'Global'
  properties: {
    enabledState: 'Enabled'
  }
}

///// Custom Domain ///// 


// Test
resource profiles_afd_testname_test_id_reedinpartnership_co_uk 'Microsoft.Cdn/profiles/customdomains@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'test-id-reedinpartnership-co-uk'
  properties: {
    hostName: 'test.id.reedinpartnership.co.uk'
    tlsSettings: {
      certificateType: 'ManagedCertificate'
      minimumTlsVersion: 'TLS12'
    }
  }
}

resource profiles_afd_testname_test_polaris_reedinpartnership_co_uk 'Microsoft.Cdn/profiles/customdomains@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'test-polaris-reedinpartnership-co-uk'
  properties: {
    hostName: 'test.polaris.reedinpartnership.co.uk'
    tlsSettings: {
      certificateType: 'ManagedCertificate'
      minimumTlsVersion: 'TLS12'
    }
  }
}

// UAT
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

// TRN
resource profiles_afd_trnname_trn_id_reedinpartnership_co_uk 'Microsoft.Cdn/profiles/customdomains@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'trn-id-reedinpartnership-co-uk'
  properties: {
    hostName: 'trn.id.reedinpartnership.co.uk'
    tlsSettings: {
      certificateType: 'ManagedCertificate'
      minimumTlsVersion: 'TLS12'
    }
  }
}

resource profiles_afd_trnname_trn_polaris_reedinpartnership_co_uk 'Microsoft.Cdn/profiles/customdomains@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'trn-polaris-reedinpartnership-co-uk'
  properties: {
    hostName: 'trn.polaris.reedinpartnership.co.uk'
    tlsSettings: {
      certificateType: 'ManagedCertificate'
      minimumTlsVersion: 'TLS12'
    }
  }
}

//PROD

resource profiles_afd_prodname_prod_id_reedinpartnership_co_uk 'Microsoft.Cdn/profiles/customdomains@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'prod-id-reedinpartnership-co-uk'
  properties: {
    hostName: 'id.reedinpartnership.co.uk'
    tlsSettings: {
      certificateType: 'ManagedCertificate'
      minimumTlsVersion: 'TLS12'
    }
  }
}

resource profiles_afd_prodname_prod_polaris_reedinpartnership_co_uk 'Microsoft.Cdn/profiles/customdomains@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'prod-polaris-reedinpartnership-co-uk'
  properties: {
    hostName: 'polaris.reedinpartnership.co.uk'
    tlsSettings: {
      certificateType: 'ManagedCertificate'
      minimumTlsVersion: 'TLS12'
      
    }
  }
}




///// Origin Groups /////

// Test
resource profiles_afd_testname_polaris_test_adb2c_custom_ui_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test-adb2c-custom-ui-origin-group'
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



resource profiles_afd_testname_polaris_test_adb2c_tenant_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test-adb2c-tenant-origin-group'
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

resource profiles_afd_testname_polaris_test_frontend_origingroup 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test-frontend-origingroup'
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

resource profiles_afd_testname_polaris_test_spring_users_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test-spring-users-origin-group'
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

resource profiles_afd_courses_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test-spring-courses-origin-group'
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

resource profiles_afd_participants_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test-spring-participants-origin-group'
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

resource profiles_afd_communication_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test-spring-communication-origin-group'
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

resource profiles_afd_directus_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test-spring-directus-origin-group'
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

resource profiles_afd_calendar_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test-spring-calendar-origin-group'
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

// resource profiles_afd_test_upload_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
//   parent: profiles_afd
//   name: 'polaris-test-documents-upload-origin-group'
//   properties: {
//     loadBalancingSettings: {
//       sampleSize: 4
//       successfulSamplesRequired: 3
//       additionalLatencyInMilliseconds: 50
//     }
//     healthProbeSettings: {
//       probePath: '/'
//       probeRequestType: 'HEAD'
//       probeProtocol: 'Http'
//       probeIntervalInSeconds: 240
//     }
//     sessionAffinityState: 'Disabled'
//   }
// }

resource profiles_afd_test_documents_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test-spring-documents-origin-group'
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

resource profiles_afd_test_recruitment_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test-spring-recruitment-origin-group'
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

// resource profiles_afd_testname_43968438_875b_419f_9241_505f4a43b777_test_polaris_reedinpartnership_co_uk 'Microsoft.Cdn/profiles/secrets@2022-11-01-preview' = {
//   parent: profiles_afd
//   name: '43968438-875b-419f-9241-505f4a43b777-test-polaris-reedinpartnership-co-uk'
//   properties: {
//     parameters: {
//       type: 'ManagedCertificate'
//     }
//   }
// }

// UAT
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

resource profiles_afd_uat_communication_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-spring-communication-origin-group'
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

resource profiles_afd_uat_calendar_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-spring-calendar-origin-group'
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

// resource profiles_afd_upload_uat_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
//   parent: profiles_afd
//   name: 'polaris-uat-documents-upload-origin-group'
//   properties: {
//     loadBalancingSettings: {
//       sampleSize: 4
//       successfulSamplesRequired: 3
//       additionalLatencyInMilliseconds: 50
//     }
//     healthProbeSettings: {
//       probePath: '/'
//       probeRequestType: 'HEAD'
//       probeProtocol: 'Http'
//       probeIntervalInSeconds: 240
//     }
//     sessionAffinityState: 'Disabled'
//   }
// }

resource profiles_afd_uat_documents_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-spring-documents-origin-group'
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

resource profiles_afd_uat_recruitment_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-spring-recruitment-origin-group'
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

// TRN
resource profiles_afd_trnname_polaris_trn_adb2c_custom_ui_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn-adb2c-custom-ui-origin-group'
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

resource profiles_afd_trnname_polaris_trn_adb2c_tenant_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn-adb2c-tenant-origin-group'
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

resource profiles_afd_trnname_polaris_trn_frontend_origingroup 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn-frontend-origingroup'
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

resource profiles_afd_trnname_polaris_trn_spring_users_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn-spring-users-origin-group'
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

resource profiles_afd_courses_trn_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn-spring-courses-origin-group'
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

resource profiles_afd_trn_participants_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn-spring-participants-origin-group'
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

resource profiles_afd_trn_communication_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn-spring-communication-origin-group'
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

resource profiles_afd_trn_directus_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn-spring-directus-origin-group'
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

resource profiles_afd_trn_calendar_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn-spring-calendar-origin-group'
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


resource profiles_afd_trn_documents_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn-spring-documents-origin-group'
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

resource profiles_afd_trn_recruitment_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn-spring-recruitment-origin-group'
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

//PROD

resource profiles_afd_prodname_polaris_prod_adb2c_custom_ui_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod-adb2c-custom-ui-origin-group'
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

resource profiles_afd_prodname_polaris_prod_adb2c_tenant_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod-adb2c-tenant-origin-group'
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

resource profiles_afd_prodname_polaris_prod_frontend_origingroup 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod-frontend-origingroup'
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

resource profiles_afd_prodname_polaris_prod_spring_users_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod-spring-users-origin-group'
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

resource profiles_afd_courses_prod_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod-spring-courses-origin-group'
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

resource profiles_afd_prod_participants_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod-spring-participants-origin-group'
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

resource profiles_afd_prod_communication_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod-spring-communication-origin-group'
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

resource profiles_afd_prod_directus_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod-spring-directus-origin-group'
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

resource profiles_afd_prod_calendar_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod-spring-calendar-origin-group'
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


resource profiles_afd_prod_documents_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod-spring-documents-origin-group'
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

resource profiles_afd_prod_recruitment_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod-spring-recruitment-origin-group'
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

//Test
resource profiles_afd_testname_polaris_test_adb2c_custom_ui_origin_group_polaris_test_adb2c_custom_ui_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test_adb2c_custom_ui_origin_group
  name: 'polaris-test-adb2c-custom-ui-origin'
  properties: {
    hostName: 'yellow-pond-099d3f303.3.azurestaticapps.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'yellow-pond-099d3f303.3.azurestaticapps.net'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_testname_polaris_test_adb2c_tenant_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test_adb2c_tenant_origin_group
  name: 'polaris-test-adb2c-tenant-origin'
  properties: {
    hostName: 'rinppolaristest.b2clogin.com'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'rinppolaristest.b2clogin.com'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_testname_frontend_polaris_test_frontend_swa_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test_frontend_origingroup
  name: 'polaris-test-frontend-swa-origin'
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

resource profiles_afd_testname_polaris_test_spring_users_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test_spring_users_origin_group
  name: 'polaris-test-spring-users-origin'
  properties: {
    hostName: 'spring-polaris-test-uksouth-user-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-test-uksouth-user-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_test_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_courses_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_courses_origin_group
  name: 'polaris-test-spring-courses-origin'
  properties: {
    hostName: 'spring-polaris-test-uksouth-course-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-test-uksouth-course-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_test_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_participants_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_participants_origin_group
  name: 'polaris-test-spring-participants-origin'
  properties: {
    hostName: 'spring-polaris-test-uksouth-participant-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-test-uksouth-participant-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_test_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_communication_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_communication_origin_group
  name: 'polaris-test-spring-communication-origin'
  properties: {
    hostName: 'spring-polaris-test-uksouth-communication-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-test-uksouth-communication-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_test_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_directus_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_directus_origin_group
  name: 'polaris-test-spring-directus-origin'
  properties: {
    hostName: 'spring-polaris-test-uksouth-directus-management-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-test-uksouth-directus-management-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_test_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_calendar_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_calendar_origin_group
  name: 'polaris-test-spring-calendar-origin'
  properties: {
    hostName: 'spring-polaris-test-uksouth-calendar-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-test-uksouth-calendar-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_test_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_documents_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_test_documents_origin_group
  name: 'polaris-test-spring-documents-origin'
  properties: {
    hostName: 'spring-polaris-test-uksouth-document-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-test-uksouth-document-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_test_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'Polaris Test AFD route documents upload'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_recruitments_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_test_recruitment_origin_group
  name: 'polaris-test-spring-recruitment-origin'
  properties: {
    hostName: 'spring-polaris-test-uksouth-recruitment-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-test-uksouth-recruitment-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_test_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'Polaris Test AFD route recruitment'
    }
    enforceCertificateNameCheck: true
  }
}



// UAT
resource profiles_afd_uatname_polaris_uat_adb2c_custom_ui_origin_group_polaris_uat_adb2c_custom_ui_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat_adb2c_custom_ui_origin_group
  name: 'polaris-uat-adb2c-custom-ui-origin'
  properties: {
    hostName: 'lemon-river-068689c03.3.azurestaticapps.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'lemon-river-068689c03.3.azurestaticapps.net'
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
    hostName: 'orange-ocean-054363203.3.azurestaticapps.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'orange-ocean-054363203.3.azurestaticapps.net'
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

resource profiles_afd_uat_communication_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_uat_communication_origin_group
  name: 'polaris-uat-spring-communication-origin'
  properties: {
    hostName: 'spring-polaris-uat-uksouth-communication-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-uat-uksouth-communication-service.private.azuremicroservices.io'
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

resource profiles_afd_uat_calendar_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_uat_calendar_origin_group
  name: 'polaris-uat-spring-calendar-origin'
  properties: {
    hostName: 'spring-polaris-uat-uksouth-calendar-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-uat-uksouth-calendar-service.private.azuremicroservices.io'
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

resource profiles_afd_uat_documents_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_uat_documents_origin_group
  name: 'polaris-uat-spring-documents-origin'
  properties: {
    hostName: 'spring-polaris-uat-uksouth-document-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-uat-uksouth-document-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_uat_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'Polaris uat AFD route documents upload'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_uat_recruitments_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_uat_recruitment_origin_group
  name: 'polaris-uat-spring-recruitment-origin'
  properties: {
    hostName: 'spring-polaris-uat-uksouth-recruitment-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-uat-uksouth-recruitment-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_uat_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'Polaris UAT AFD route recruitment'
    }
    enforceCertificateNameCheck: true
  }
}

// TRN
resource profiles_afd_trnname_polaris_trn_adb2c_custom_ui_origin_group_polaris_trn_adb2c_custom_ui_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn_adb2c_custom_ui_origin_group
  name: 'polaris-trn-adb2c-custom-ui-origin'
  properties: {
    hostName: 'lemon-pond-0fbd04d03.4.azurestaticapps.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'lemon-pond-0fbd04d03.4.azurestaticapps.net'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_trnname_polaris_trn_adb2c_tenant_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn_adb2c_tenant_origin_group
  name: 'polaris-trn-adb2c-tenant-origin'
  properties: {
    hostName: 'rinppolaristrn.b2clogin.com'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'rinppolaristrn.b2clogin.com'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_trnname_frontend_polaris_trn_frontend_swa_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn_frontend_origingroup
  name: 'polaris-trn-frontend-swa-origin'
  properties: {
    hostName: 'ambitious-sky-04b26a903.4.azurestaticapps.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'ambitious-sky-04b26a903.4.azurestaticapps.net'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_trnname_polaris_trn_spring_users_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn_spring_users_origin_group
  name: 'polaris-trn-spring-users-origin'
  properties: {
    hostName: 'spring-polaris-trn-uksouth-user-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-trn-uksouth-user-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_trn_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_trn_courses_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_courses_trn_origin_group
  name: 'polaris-trn-spring-courses-origin'
  properties: {
    hostName: 'spring-polaris-trn-uksouth-course-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-trn-uksouth-course-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_trn_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_trn_participants_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_trn_participants_origin_group
  name: 'polaris-trn-spring-participants-origin'
  properties: {
    hostName: 'spring-polaris-trn-uksouth-participant-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-trn-uksouth-participant-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_trn_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_trn_communication_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_trn_communication_origin_group
  name: 'polaris-trn-spring-communication-origin'
  properties: {
    hostName: 'spring-polaris-trn-uksouth-communication-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-trn-uksouth-communication-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_trn_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_trn_directus_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_trn_directus_origin_group
  name: 'polaris-trn-spring-directus-origin'
  properties: {
    hostName: 'spring-polaris-trn-uksouth-directus-management-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-trn-uksouth-directus-management-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_trn_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_trn_calendar_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_trn_calendar_origin_group
  name: 'polaris-trn-spring-calendar-origin'
  properties: {
    hostName: 'spring-polaris-trn-uksouth-calendar-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-trn-uksouth-calendar-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_trn_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}


resource profiles_afd_trn_documents_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_trn_documents_origin_group
  name: 'polaris-trn-spring-documents-origin'
  properties: {
    hostName: 'spring-polaris-trn-uksouth-document-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-trn-uksouth-document-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_trn_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'Polaris trn AFD route documents upload'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_trn_recruitments_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_trn_recruitment_origin_group
  name: 'polaris-trn-spring-recruitment-origin'
  properties: {
    hostName: 'spring-polaris-trn-uksouth-recruitment-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-trn-uksouth-recruitment-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_trn_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'Polaris TRN AFD route recruitment'
    }
    enforceCertificateNameCheck: true
  }
}

//PROD

resource profiles_afd_prodname_polaris_prod_adb2c_custom_ui_origin_group_polaris_prod_adb2c_custom_ui_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod_adb2c_custom_ui_origin_group
  name: 'polaris-prod-adb2c-custom-ui-origin'
  properties: {
    hostName: 'lively-flower-000141503.5.azurestaticapps.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'lively-flower-000141503.5.azurestaticapps.net'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_prodname_polaris_prod_adb2c_tenant_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod_adb2c_tenant_origin_group
  name: 'polaris-prod-adb2c-tenant-origin'
  properties: {
    hostName: 'rinppolarisprod.b2clogin.com'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'rinppolarisprod.b2clogin.com'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_prodname_frontend_polaris_prod_frontend_swa_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod_frontend_origingroup
  name: 'polaris-prod-frontend-swa-origin'
  properties: {
    hostName: 'lively-ocean-0b466c803.5.azurestaticapps.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'lively-ocean-0b466c803.5.azurestaticapps.net'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_prodname_polaris_prod_spring_users_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod_spring_users_origin_group
  name: 'polaris-prod-spring-users-origin'
  properties: {
    hostName: 'spring-polaris-prod-uksouth-user-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-prod-uksouth-user-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_prod_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_prod_courses_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_courses_prod_origin_group
  name: 'polaris-prod-spring-courses-origin'
  properties: {
    hostName: 'spring-polaris-prod-uksouth-course-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-prod-uksouth-course-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_prod_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_prod_participants_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_prod_participants_origin_group
  name: 'polaris-prod-spring-participants-origin'
  properties: {
    hostName: 'spring-polaris-prod-uksouth-participant-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-prod-uksouth-participant-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_prod_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_prod_communication_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_prod_communication_origin_group
  name: 'polaris-prod-spring-communication-origin'
  properties: {
    hostName: 'spring-polaris-prod-uksouth-communication-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-prod-uksouth-communication-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_prod_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_prod_directus_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_prod_directus_origin_group
  name: 'polaris-prod-spring-directus-origin'
  properties: {
    hostName: 'spring-polaris-prod-uksouth-directus-management-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-prod-uksouth-directus-management-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_prod_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_prod_calendar_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_prod_calendar_origin_group
  name: 'polaris-prod-spring-calendar-origin'
  properties: {
    hostName: 'spring-polaris-prod-uksouth-calendar-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-prod-uksouth-calendar-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_prod_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'please approve'
    }
    enforceCertificateNameCheck: true
  }
}


resource profiles_afd_prod_documents_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_prod_documents_origin_group
  name: 'polaris-prod-spring-documents-origin'
  properties: {
    hostName: 'spring-polaris-prod-uksouth-document-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-prod-uksouth-document-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_prod_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'Polaris prod AFD route documents upload'
    }
    enforceCertificateNameCheck: true
  }
}

resource profiles_afd_prod_recruitments_origins 'Microsoft.Cdn/profiles/origingroups/origins@2022-11-01-preview' = {
  parent: profiles_afd_prod_recruitment_origin_group
  name: 'polaris-prod-spring-recruitment-origin'
  properties: {
    hostName: 'spring-polaris-prod-uksouth-recruitment-service.private.azuremicroservices.io'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'spring-polaris-prod-uksouth-recruitment-service.private.azuremicroservices.io'
    priority: 1
    weight: 1000
    enabledState: 'Enabled'
    sharedPrivateLinkResource: {
      privateLink: {
        id: privateLinkServices_pl_springapps_polaris_prod_externalid
      }
      privateLinkLocation: 'uksouth'
      requestMessage: 'Polaris PROD AFD route recruitment'
    }
    enforceCertificateNameCheck: true
  }
}



///// Security Policy /////


// Test
resource profiles_afd_testname_polaris_test_security_policy 'Microsoft.Cdn/profiles/securitypolicies@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-test-security-policy'
  properties: {
    parameters: {
      wafPolicy: {
        id: wafpolaristestid
      }
      associations: [
        {
          domains: [
            {
              id: profiles_afd_testname_test_polaris_reedinpartnership_co_uk.id
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

// UAT

resource profiles_afd_uatname_polaris_uat_security_policy 'Microsoft.Cdn/profiles/securitypolicies@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-uat-security-policy'
  properties: {
    parameters: {
      wafPolicy: {
        id: wafpolarisuatid
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

// TRN

resource profiles_afd_trnname_polaris_trn_security_policy 'Microsoft.Cdn/profiles/securitypolicies@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-trn-security-policy'
  properties: {
    parameters: {
      wafPolicy: {
        id: wafpolaristrnid
      }
      associations: [
        {
          domains: [
            {
              id: profiles_afd_trnname_trn_polaris_reedinpartnership_co_uk.id
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


// PROD

resource profiles_afd_prodname_polaris_prod_security_policy 'Microsoft.Cdn/profiles/securitypolicies@2022-11-01-preview' = {
  parent: profiles_afd
  name: 'polaris-prod-security-policy'
  properties: {
    parameters: {
      wafPolicy: {
        id: wafpolarisprodid
      }
      associations: [
        {
          domains: [
            {
              id: profiles_afd_prodname_prod_polaris_reedinpartnership_co_uk.id
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


// New Policy - All IP in one policy 





//////////////////
///// Routes /////
//////////////////




///////////
// Test //
//////////
resource profiles_afd_testname_polaris_test_default_route 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test
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
        id: profiles_afd_testname_test_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_testname_polaris_test_frontend_origingroup.id
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

resource profiles_afd_testname_polaris_test_identity_adb2c_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test
  name: 'identity-adb2c'
  properties: {
    customDomains: [
      {
        id: profiles_afd_testname_test_id_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_testname_polaris_test_adb2c_tenant_origin_group.id
    }
    ruleSets: [
      {
        id: test_cors_rule_set.id
      }
    ]
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

resource profiles_afd_testname_polaris_test_identity_adb2c_custom_ui_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test
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
        id: profiles_afd_testname_test_id_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_testname_polaris_test_adb2c_custom_ui_origin_group.id
    }
    ruleSets: [
      {
        id: test_cors_rule_set.id
      }
    ]
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

resource profiles_afd_testname_polaris_test_services_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test
  name: 'services-users'
  properties: {
    customDomains: [
      {
        id: profiles_afd_testname_test_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_testname_polaris_test_spring_users_origin_group.id
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

resource profiles_afd_testname_polaris_test_courses_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test
  name: 'services-courses'
  properties: {
    customDomains: [
      {
        id: profiles_afd_testname_test_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_courses_origin_group.id
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

resource profiles_afd_testname_polaris_test_participants_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test
  name: 'services-participants'
  properties: {
    customDomains: [
      {
        id: profiles_afd_testname_test_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_participants_origin_group.id
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

resource profiles_afd_testname_polaris_test_communication_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test
  name: 'services-communication'
  properties: {
    customDomains: [
      {
        id: profiles_afd_testname_test_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_communication_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/communication/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_testname_polaris_test_directus_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test
  name: 'services-directus'
  properties: {
    customDomains: [
      {
        id: profiles_afd_testname_test_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_directus_origin_group.id
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

resource profiles_afd_testname_polaris_test_calendar_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test
  name: 'services-calendar'
  properties: {
    customDomains: [
      {
        id: profiles_afd_testname_test_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_calendar_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/calendar/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

// resource profiles_afd_testname_polaris_test_upload_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
//   parent: profiles_afd_testname_polaris_test
//   name: 'upload-documents'
//   properties: {
//     customDomains: [
//       {
//         id: profiles_afd_testname_test_polaris_reedinpartnership_co_uk.id
//       }
//     ]
//     originGroup: {
//       id: profiles_afd_test_upload_origin_group.id
//     }
//     originPath: '/'
//     ruleSets: []
//     supportedProtocols: [
//       'Http'
//       'Https'
//     ]
//     patternsToMatch: [
//       '/upload/*'
//     ]
//     forwardingProtocol: 'HttpsOnly'
//     linkToDefaultDomain: 'Disabled'
//     httpsRedirect: 'Enabled'
//     enabledState: 'Enabled'
//   }
// }

resource profiles_afd_testname_polaris_test_documents_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test
  name: 'services-documents'
  properties: {
    customDomains: [
      {
        id: profiles_afd_testname_test_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_test_documents_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/documents/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_testname_polaris_test_documents_recruitment 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_testname_polaris_test
  name: 'services-recruitment'
  properties: {
    customDomains: [
      {
        id: profiles_afd_testname_test_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_test_recruitment_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/recruitment/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}


///////////
// UAT  //
//////////

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
    ruleSets: [
      {
        id: uat_cors_rule_set.id
      }
    ]
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
    ruleSets: [
      {
        id: uat_cors_rule_set.id
      }
    ]
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

resource profiles_afd_uatname_polaris_uat_communication_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat
  name: 'services-communication'
  properties: {
    customDomains: [
      {
        id: profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_uat_communication_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/communication/*'
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

resource profiles_afd_uatname_polaris_uat_calendar_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat
  name: 'services-calendar'
  properties: {
    customDomains: [
      {
        id: profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_uat_calendar_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/calendar/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

// resource profiles_afd_testname_polaris_uat_upload_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
//   parent: profiles_afd_uatname_polaris_uat
//   name: 'upload-documents'
//   properties: {
//     customDomains: [
//       {
//         id: profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk.id
//       }
//     ]
//     originGroup: {
//       id: profiles_afd_upload_uat_origin_group.id
//     }
//     originPath: '/'
//     ruleSets: []
//     supportedProtocols: [
//       'Http'
//       'Https'
//     ]
//     patternsToMatch: [
//       '/upload/*'
//     ]
//     forwardingProtocol: 'HttpsOnly'
//     linkToDefaultDomain: 'Disabled'
//     httpsRedirect: 'Enabled'
//     enabledState: 'Enabled'
//   }
// }

resource profiles_afd_testname_polaris_uat_documents_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat
  name: 'services-documents'
  properties: {
    customDomains: [
      {
        id: profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_uat_documents_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/documents/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_testname_polaris_uat_recruitment_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_uatname_polaris_uat
  name: 'services-recruitment'
  properties: {
    customDomains: [
      {
        id: profiles_afd_uatname_uat_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_uat_recruitment_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/recruitment/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

///////////
// TRN  //
//////////


resource profiles_afd_trnname_polaris_trn_default_route 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn
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
        id: profiles_afd_trnname_trn_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_trnname_polaris_trn_frontend_origingroup.id
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

resource profiles_afd_trnname_polaris_trn_identity_adb2c_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn
  name: 'identity-adb2c'
  properties: {
    customDomains: [
      {
        id: profiles_afd_trnname_trn_id_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_trnname_polaris_trn_adb2c_tenant_origin_group.id
    }
    ruleSets: [
      {
        id: trn_cors_rule_set.id
      }
    ]
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

resource profiles_afd_trnname_polaris_trn_identity_adb2c_custom_ui_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn
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
        id: profiles_afd_trnname_trn_id_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_trnname_polaris_trn_adb2c_custom_ui_origin_group.id
    }
    ruleSets: [
      {
        id: trn_cors_rule_set.id
      }
    ]
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

resource profiles_afdtrnname_polaris_trn_services_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn
  name: 'services-users'
  properties: {
    customDomains: [
      {
        id: profiles_afd_trnname_trn_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_trnname_polaris_trn_spring_users_origin_group.id
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

resource profiles_afd_trnname_polaris_trn_courses_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn
  name: 'services-courses'
  properties: {
    customDomains: [
      {
        id: profiles_afd_trnname_trn_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_courses_trn_origin_group.id
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

resource profiles_afd_trnname_polaris_trn_participants_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn
  name: 'services-participants'
  properties: {
    customDomains: [
      {
        id: profiles_afd_trnname_trn_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_trn_participants_origin_group.id
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

resource profiles_afd_trnname_polaris_trn_communication_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn
  name: 'services-communication'
  properties: {
    customDomains: [
      {
        id: profiles_afd_trnname_trn_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_trn_communication_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/communication/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_trnname_polaris_trn_directus_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn
  name: 'services-directus'
  properties: {
    customDomains: [
      {
        id: profiles_afd_trnname_trn_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_trn_directus_origin_group.id
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

resource profiles_afd_trnname_polaris_trn_calendar_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn
  name: 'services-calendar'
  properties: {
    customDomains: [
      {
        id: profiles_afd_trnname_trn_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_trn_calendar_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/calendar/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_trname_polaris_trn_documents_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn
  name: 'services-documents'
  properties: {
    customDomains: [
      {
        id: profiles_afd_trnname_trn_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_trn_documents_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/documents/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_testname_polaris_trn_recruitment_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_trnname_polaris_trn
  name: 'services-recruitment'
  properties: {
    customDomains: [
      {
        id: profiles_afd_trnname_trn_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_trn_recruitment_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/recruitment/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}


///////////
// PROD  //
//////////

resource profiles_afd_prodname_polaris_prod_default_route 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod
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
        id: profiles_afd_prodname_prod_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_prodname_polaris_prod_frontend_origingroup.id
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

resource profiles_afd_prodname_polaris_prod_identity_adb2c_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod
  name: 'identity-adb2c'
  properties: {
    customDomains: [
      {
        id: profiles_afd_prodname_prod_id_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_prodname_polaris_prod_adb2c_tenant_origin_group.id
    }
    ruleSets: [
      {
        id: prod_cors_rule_set.id
      }
    ]
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

resource profiles_afd_prodname_polaris_prod_identity_adb2c_custom_ui_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod
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
        id: profiles_afd_prodname_prod_id_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_prodname_polaris_prod_adb2c_custom_ui_origin_group.id
    }
    ruleSets: [
      {
        id: prod_cors_rule_set.id
      }
    ]
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

resource profiles_afd_prodname_polaris_prod_services_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod
  name: 'services-users'
  properties: {
    customDomains: [
      {
        id: profiles_afd_prodname_prod_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_prodname_polaris_prod_spring_users_origin_group.id
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

resource profiles_afd_prodname_polaris_prod_courses_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod
  name: 'services-courses'
  properties: {
    customDomains: [
      {
        id: profiles_afd_prodname_prod_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_courses_prod_origin_group.id
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

resource profiles_afd_prodname_polaris_prod_participants_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod
  name: 'services-participants'
  properties: {
    customDomains: [
      {
        id: profiles_afd_prodname_prod_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_prod_participants_origin_group.id
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

resource profiles_afd_prodname_polaris_prod_communication_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod
  name: 'services-communication'
  properties: {
    customDomains: [
      {
        id: profiles_afd_prodname_prod_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_prod_communication_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/communication/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_prodname_polaris_prod_directus_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod
  name: 'services-directus'
  properties: {
    customDomains: [
      {
        id: profiles_afd_prodname_prod_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_prod_directus_origin_group.id
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

resource profiles_afd_prodname_polaris_prod_calendar_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod
  name: 'services-calendar'
  properties: {
    customDomains: [
      {
        id: profiles_afd_prodname_prod_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_prod_calendar_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/calendar/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}


resource profiles_afd_prodname_polaris_prod_documents_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod
  name: 'services-documents'
  properties: {
    customDomains: [
      {
        id: profiles_afd_prodname_prod_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_prod_documents_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/documents/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}

resource profiles_afd_prodname_polaris_prod_recruitment_routes 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-11-01-preview' = {
  parent: profiles_afd_prodname_polaris_prod
  name: 'services-recruitment'
  properties: {
    customDomains: [
      {
        id: profiles_afd_prodname_prod_polaris_reedinpartnership_co_uk.id
      }
    ]
    originGroup: {
      id: profiles_afd_prod_recruitment_origin_group.id
    }
    originPath: '/'
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/services/recruitment/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Disabled'
    httpsRedirect: 'Enabled'
    enabledState: 'Enabled'
  }
}


///CUSTOM CORS RULE SET FOR TEST///

resource test_cors_rule_set 'Microsoft.Cdn/profiles/ruleSets@2023-07-01-preview' = {
  name: 'testcorsruleset'
  parent: profiles_afd
}

///CUSTOM CORS RULE SET FOR UAT///

resource uat_cors_rule_set 'Microsoft.Cdn/profiles/ruleSets@2023-07-01-preview' = {
  name: 'uatcorsruleset'
  parent: profiles_afd
}

///CUSTOM CORS RULE SET FOR TRN///

resource trn_cors_rule_set 'Microsoft.Cdn/profiles/ruleSets@2023-07-01-preview' = {
  name: 'trncorsruleset'
  parent: profiles_afd
}


// ///CUSTOM CORS RULE SET FOR PROD///

resource prod_cors_rule_set 'Microsoft.Cdn/profiles/ruleSets@2023-07-01-preview' = {
  name: 'prodcorsruleset'
  parent: profiles_afd
}


//TEST CORS RULE//

resource testcorsrule 'Microsoft.Cdn/profiles/ruleSets/rules@2023-07-01-preview' = {
  name: 'testcorsrule'
  parent: test_cors_rule_set
  properties: {
    actions: [
      {
        name: 'ModifyResponseHeader'
        parameters: {
          headerAction: 'Overwrite'
          headerName: 'Access-Control-Allow-Origin'
          typeName: 'DeliveryRuleHeaderActionParameters'
          value: 'https://test.polaris.reedinpartnership.co.uk'
        }
      }
    ]
   
    matchProcessingBehavior: 'Continue'
  }
}
      
 
         
//UAT CORS RULE//

resource uatcorsrule 'Microsoft.Cdn/profiles/ruleSets/rules@2023-07-01-preview' = {
  name: 'uatcorsrule'
  parent: uat_cors_rule_set
  properties: {
    actions: [
      {
        name: 'ModifyResponseHeader'
        parameters: {
          headerAction: 'Overwrite'
          headerName: 'Access-Control-Allow-Origin'
          typeName: 'DeliveryRuleHeaderActionParameters'
          value: 'https://uat.polaris.reedinpartnership.co.uk'
        }
      }
    ]
    matchProcessingBehavior: 'Continue'
  }
}


//TRN CORS RULE//

resource trncorsrule 'Microsoft.Cdn/profiles/ruleSets/rules@2023-07-01-preview' = {
  name: 'trncorsrule'
  parent: trn_cors_rule_set
  properties: {
    actions: [
      {
        name: 'ModifyResponseHeader'
        parameters: {
          headerAction: 'Overwrite'
          headerName: 'Access-Control-Allow-Origin'
          typeName: 'DeliveryRuleHeaderActionParameters'
          value: 'https://trn.polaris.reedinpartnership.co.uk'
        }
      }
    ]
    
    matchProcessingBehavior: 'Continue'
  }
}

//PROD CORS RULE//

resource prodcorsrule 'Microsoft.Cdn/profiles/ruleSets/rules@2023-07-01-preview' = {
  name: 'prodcorsrule'
  parent: prod_cors_rule_set
  properties: {
    actions: [
      {
        name: 'ModifyResponseHeader'
        parameters: {
          headerAction: 'Overwrite'
          headerName: 'Access-Control-Allow-Origin'
          typeName: 'DeliveryRuleHeaderActionParameters'
          value: 'https://polaris.reedinpartnership.co.uk'
        }
      }
    ]
   
    matchProcessingBehavior: 'Continue'
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
