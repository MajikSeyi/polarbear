targetScope = 'subscription'

param testsub string = 'f00e932c-2dc9-4eed-83ab-28bee4d9dbb3'
param testsubid string = '/subscriptions/f00e932c-2dc9-4eed-83ab-28bee4d9dbb3'
param uatsubid string = '/subscriptions/8e9001ef-d089-4768-b516-ae4be3e68dde'
param uatsub string = '8e9001ef-d089-4768-b516-ae4be3e68dde'
param trnsubid string = '/subscriptions/28949f95-bda6-4716-a7f7-3b13b40d1301e'
param trnsub string = '28949f95-bda6-4716-a7f7-3b13b40d1301'
param prodsubid string = '/subscriptions/95ca7646-ed92-470e-9dfb-23f25093d507'
param prodsub string = '95ca7646-ed92-470e-9dfb-23f25093d507'
param managedsub string = '3592b1b4-dca4-42c2-95dc-bf0902211479'
param gatewaysub string = 'e22eb6a5-6f38-4574-9b84-1c1dbe1c8b97'
param rg_shared_monitoring string = 'rg-shared-monitoring'
param rg_springapp string = 'rg-springapps'


resource lawaudit 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: 'm365azuresentinel-dw-prod-uks-la'
  scope: resourceGroup('e7fe7e3e-7874-4903-87be-422595a82d07','it-dw-sentinel-logs-production-rg' )
}

resource lawoperations 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: 'law-shared-operational-uksouth'
  scope: resourceGroup('3592b1b4-dca4-42c2-95dc-bf0902211479','rg-shared-monitoring' )
}



//// Sub export activity logs ////

// Action group 
// Spring apps - Action Group
module actionGroups '../../modules/Microsoft.Insights/actionGroups/deploy.bicep' = {
  name: '${uniqueString(deployment().name)}--sharedsubmonitor'
  scope: resourceGroup(managedsub, rg_shared_monitoring )
  params: {
    // Required parameters`
    groupShortName: 'iag-active'
    name: 'alts' // Activity log subs action groups
    // Non-required parameters
    emailReceivers: [
      {
        emailAddress: 'alex.hunte@reed.com'
        name: 'Alex Hunte'
        useCommonAlertSchema: true
      }
    ]
  }
}

// Activity Test Sub
module subactiviationtest '../../modules/Microsoft.OperationalInsights/activitydeploy.bicep' = {
  scope: subscription(testsub)
  name: '${uniqueString(deployment().name)}-activitylogs-test'
  params: {
    env: 'test'
    Workspaceidaudit: lawaudit.id 
    Workspaceidoperation: lawoperations.id
  }
}

module activateallcriticaltest '../../modules/Microsoft.OperationalInsights/activityallcritical.bicep' = {
  scope: resourceGroup(testsub, rg_springapp )
  name: '${uniqueString(deployment().name)}-activitylogs-test-polaris' 
  params: {
    actionGroupId: actionGroups.outputs.resourceId 
    activitylogalerts_name: 'alert-polaris-test-service-health'
    scopesubscription: testsubid
  }
}

// Activity UAT Sub
module subactiviationuat '../../modules/Microsoft.OperationalInsights/activitydeploy.bicep' = {
  scope: subscription(uatsub)
  name: '${uniqueString(deployment().name)}-activitylogs-uat'
  params: {
    env: 'uat'
    Workspaceidaudit: lawaudit.id 
    Workspaceidoperation: lawoperations.id
  }
}

module activateallcriticaluat '../../modules/Microsoft.OperationalInsights/activityallcritical.bicep' = {
  scope: resourceGroup(uatsub, rg_springapp )
  name: '${uniqueString(deployment().name)}-activitylogs-uat-polaris' 
  params: {
    actionGroupId: actionGroups.outputs.resourceId 
    activitylogalerts_name: 'alert-polaris-uat-service-health'
    scopesubscription: uatsubid
  }
}

// Activity TRN Sub
module subactiviationtrn '../../modules/Microsoft.OperationalInsights/activitydeploy.bicep' = {
  scope: subscription(trnsub)
  name: '${uniqueString(deployment().name)}-activitylogs-trn'
  params: {
    env: 'trn'
    Workspaceidaudit: lawaudit.id 
    Workspaceidoperation: lawoperations.id
  }
}

module activateallcriticaltrn '../../modules/Microsoft.OperationalInsights/activityallcritical.bicep' = {
  scope: resourceGroup(trnsub, rg_springapp )
  name: '${uniqueString(deployment().name)}-activitylogs-trn-polaris' 
  params: {
    actionGroupId: actionGroups.outputs.resourceId 
    activitylogalerts_name: 'alert-polaris-trn-service-health'
    scopesubscription: trnsubid
  }
}

// Activity PROD Sub
module subactiviationprod '../../modules/Microsoft.OperationalInsights/activitydeploy.bicep' = {
  scope: subscription(prodsub)
  name: '${uniqueString(deployment().name)}-activitylogs-prod'
  params: {
    env: 'prod'
    Workspaceidaudit: lawaudit.id 
    Workspaceidoperation: lawoperations.id
  }
}

module activateallcriticalprod '../../modules/Microsoft.OperationalInsights/activityallcritical.bicep' = {
  scope: resourceGroup(prodsub, rg_springapp )
  name: '${uniqueString(deployment().name)}-activitylogs-prod-polaris' 
  params: {
    actionGroupId: actionGroups.outputs.resourceId 
    activitylogalerts_name: 'alert-polaris-prod-service-health'
    scopesubscription: prodsubid
  }
}



// Activity Managed Sub
module subactiviationmanaged '../../modules/Microsoft.OperationalInsights/activitydeploy.bicep' = {
  scope: subscription(managedsub)
  name: '${uniqueString(deployment().name)}-activitylogs-managed'
  params: {
    env: 'managed'
    Workspaceidaudit: lawaudit.id 
    Workspaceidoperation: lawoperations.id
  }
}

// Activity Gateway Sub
module subactiviationgateway '../../modules/Microsoft.OperationalInsights/activitydeploy.bicep' = {
  scope: subscription(gatewaysub)
  name: '${uniqueString(deployment().name)}-activitylogs-gateway'
  params: {
    env: 'gateway'
    Workspaceidaudit: lawaudit.id 
    Workspaceidoperation: lawoperations.id
  }
}
