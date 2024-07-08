targetScope = 'subscription'


//// Parameters ////
@description('Specifies the value of the secret that you want to create.')
@secure()

param rg_springapp string // rg-springapps
param rg_shared_monitoring string //
param azurespringapp string
param ukslocation string //uksouth
param springappinsight string
param env string
param envshared string
param sharedmonitorsubscription string



//// Dependancy////



//LAW
module law '../../Shared-Services/Shared-Monitoring/shared-monitoring.bicep' = {
  name: 'lawop${env}${uniqueString(deployment().name)}-001'
  params: {
    sharedmonitorsubscription: sharedmonitorsubscription
    sharedenv: envshared
    rg_shared_monitoring: rg_shared_monitoring 
    // rg_springapp: rg_springapp
    ukslocation: ukslocation
  }
}

/////////////////////////////
//// Resource Monitoring ////
/////////////////////////////


//// Action groups //// 

// Spring apps - Action Group
module actionGroups '../../modules/Microsoft.Insights/actionGroups/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-iagcom'
  scope: resourceGroup(rg_springapp)
  params: {
    // Required parameters
    groupShortName: 'polaris-${env}'
    name: 'ag-polaris-${env}-spring'
    // Non-required parameters
    emailReceivers: [
      {
        emailAddress: 'alex.hunte@reed.com'
        name: 'Alex Hunte'
        useCommonAlertSchema: true
      }
      {
        emailAddress: 'raj.pillai@reed.com'
        name: 'Raj Pillai'
        useCommonAlertSchema: true
      }
      {
        emailAddress: 'tayo.ayodele@reed.com'
        name: 'Tayo Ayodele'
        useCommonAlertSchema: true
      }
      {
        emailAddress: 'erwin.monteagudo@reed.com'
        name: 'Erwin Monteagudo'
        useCommonAlertSchema: true
      }
      {
        emailAddress: 'sqldbas@reed.com'
        name: 'SQL DBA'
        useCommonAlertSchema: true
      }
    ]
  }
}

// Spring apps - Error-check
module springappquery '../../modules/Microsoft.Insights/scheduledQueryRules/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-isqrcom'
  scope: resourceGroup(rg_springapp)
  params: {
    // Required parameters
    targetResourceTypes: ['Microsoft.AppPlatform/Spring']
    actions: [
      actionGroups.outputs.resourceId 
    ]
    criterias: {
      allOf: [
        {
          query: '// To create an alert for this query, click \'+ New alert rule\'\nAppPlatformLogsforSpring\n| where TimeGenerated > ago(15m)\n| where Log contains "error" or Log contains "critical"\n | where not(Log has_any("Broken pipe", "No such item with id: undefined", "No such item with id: null", "A Participant with this unique identifier already exists.", "Validation errors", "ErrorReportValve.java:92", "WARN"))\n | project TimeGenerated, ServiceName, AppName, InstanceName, Log, _ResourceId \n'
          timeAggregation: 'Count'
          dimensions: []
          operator: 'GreaterThan'
          threshold: 1
          failingPeriods: {
            numberOfEvaluationPeriods: 1
            minFailingPeriodsToAlert: 1
          }
        }
      ]
    }
    name: 'alert-polaris-${env}-spring-app-logs-issues'
    scopes: [
      azurespringapp
    ]
    autoMitigate: false
    evaluationFrequency: 'PT15M'
    windowSize: 'PT15M'
  }
}

// Spring apps - Error-check
module springappsysquery '../../modules/Microsoft.Insights/scheduledQueryRules/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-sqlsycom'
  scope: resourceGroup(rg_springapp)
  params: {
    // Required parameters
    targetResourceTypes: ['Microsoft.AppPlatform/Spring']
    actions: [
      actionGroups.outputs.resourceId 
    ]
    criterias: {
      allOf: [
        {
          query: '// To create an alert for this query, click \'+ New alert rule\'\nAppPlatformSystemLogs\n| where TimeGenerated > ago(15m)\n| where LogType == "ServiceRegistry" and Level in ("ERROR")\n | where not(Log has_any("Exception"))\n | project TimeGenerated , Level , ServiceName , Thread , Stack , Log , _ResourceId'
          timeAggregation: 'Count'
          dimensions: []
          operator: 'GreaterThan'
          threshold: 1
          failingPeriods: {
            numberOfEvaluationPeriods: 1
            minFailingPeriodsToAlert: 1
          }
        }
      ]
    }
    name: 'alert-polaris-${env}-spring-system-logs-issues'
    scopes: [
      azurespringapp
    ]
    autoMitigate: false
    evaluationFrequency: 'PT15M'
    windowSize: 'PT15M'
  }
}

// Spring apps- memoryAvailableBytes - Metric

module metricAlerts '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-imacom'
  scope: resourceGroup(rg_springapp)
  params: {
    // Required parameters
    criterias: [
      {
        criterionType: 'StaticThresholdCriterion'
        metricName: 'performanceCounters/memoryAvailableBytes'
        metricNamespace: 'microsoft.insights/components'
        name: 'MetricAH'
        operator: 'LessThanOrEqual'
        threshold: '100000000'
        timeAggregation: 'Minimum'
      }
    ]
    name: 'polaris-springapps-available-${env}-memory'
    evaluationFrequency: 'PT1H' 
    autoMitigate: true
    scopes: [
      springappinsight
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.Insights/components'
    windowSize: 'PT1H'
  }
}

// Spring apps- Max App CPU Usage for spring-polaris-env-uksouth by AppName

module metricavgcpuAlerts '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-maxappcpu'
  scope: resourceGroup(rg_springapp)
  params: {
    // Required parameters
    criterias: [
      {
        criterionType: 'StaticThresholdCriterion'
        metricName: 'PodCpuUsage'
        metricNamespace: 'Microsoft.AppPlatform/Spring'
        name: 'alert-polaris-${env}-spring-cpu-utilisation'
        operator: 'GreaterThan'
        threshold: 90
        timeAggregation: 'Average'
      }
    ]
    name: 'alert-polaris-${env}-spring-cpu-utilisation'
    evaluationFrequency: 'PT1M'
    severity: 2
    autoMitigate: true
    scopes: [
      azurespringapp
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.AppPlatform/Spring'
    windowSize: 'PT1M'
  }
}

// Spring apps- Max App Memory Usage for spring-polaris-env-uksouth by AppName

module metricavgmemoryAlerts '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-maxappmemory'
  scope: resourceGroup(rg_springapp)
  params: {
    // Required parameters
    criterias: [
      {
        criterionType: 'StaticThresholdCriterion'
        metricName: 'PodMemoryUsage'
        metricNamespace: 'Microsoft.AppPlatform/Spring'
        name: 'alert-polaris-${env}-spring-memory-utilisation'
        operator: 'GreaterThan'
        threshold: 90
        timeAggregation: 'Maximum'
      }
    ]
    name: 'alert-polaris-${env}-spring-memory-utilisation'
    evaluationFrequency: 'PT1M' 
    autoMitigate: true
    severity: 2
    scopes: [
      azurespringapp
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.AppPlatform/Spring'
    windowSize: 'PT5M'
  }
}






// Spring apps- tomcat.sessions.active.current - Metric

module tomcatactivemetricAlerts '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-imactivesession'
  scope: resourceGroup(rg_springapp)
  params: {
    // Required parameters
    criterias: [
      {
        criterionType: 'StaticThresholdCriterion'
        metricName: 'tomcat.sessions.active.current'
        metricNamespace: 'Microsoft.AppPlatform/Spring'
        name: 'alert-polaris-${env}-spring-tomcat-session'
        operator: 'GreaterThan'
        threshold: '7000'
        timeAggregation: 'Total'
      }
    ]
    name: 'alert-polaris-${env}-spring-tomcat-session'
    evaluationFrequency: 'PT1M' 
    autoMitigate: true
    scopes: [
      azurespringapp
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.AppPlatform/Spring'
    windowSize: 'PT5M'
  }
}

// Spring apps- activitlylog - Informational start

module activityLogAlertspringappsstop '../../modules/Microsoft.Insights/activityLogAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-ialacom-start'
  scope: resourceGroup(rg_springapp)
  params: {
    // Required parameters
    conditions: [
      {
        field: 'category'
        equals: 'Administrative'
      }
      {
        field: 'operationName'
        equals: 'Microsoft.AppPlatform/Spring/start/action'
      }
      {
        field: 'level'
        containsAny: [
          'Informational'
        ]
      }
      {
        field: 'status'
        containsAny: [
          'started'
        ]
      }
    ]
    name: 'alert-polaris-${env}-spring-resource-health-start'
    actions: [
      {
        actionGroupId: actionGroups.outputs.resourceId
      }
    ]
    scopes: [
      azurespringapp
    ]
  }
}

// Spring apps- activitlylog - Informational Stop

module activityLogAlertspringappsstart '../../modules/Microsoft.Insights/activityLogAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-ialacom-stop'
  scope: resourceGroup(rg_springapp)
  params: {
    // Required parameters
    conditions: [
      {
        field: 'category'
        equals: 'Administrative'
      }
      {
        field: 'operationName'
        equals: 'Microsoft.AppPlatform/Spring/stop/action'
      }
      {
        field: 'level'
        containsAny: [
          'Informational'
        ]
      }
      {
        field: 'status'
        containsAny: [
          'succeeded'
        ]
      }
    ]
    name: 'alert-polaris-${env}-spring-resource-health-stop'
    actions: [
      {
        actionGroupId: actionGroups.outputs.resourceId
      }
    ]
    scopes: [
      azurespringapp
    ]
  }
}



// Spring apps- tomcat.global.error - jvm.memory.max - Metric

module tomcatactivjavamemorymetricAlerts '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-javatomcat'
  scope: resourceGroup(rg_springapp)
  params: {
    // Required parameters
    criterias: [
      {
        threshold: '996630925.4765'
        name: 'Metric1'
        metricNamespace: 'microsoft.appplatform/spring'
        metricName: 'jvm.memory.max'
        operator: 'GreaterThan'
        timeAggregation: 'Maximum'
        criterionType: 'StaticThresholdCriterion'
      }
      {
        threshold: 1
        name: 'Metric2'
        metricNamespace: 'microsoft.appplatform/spring'
        metricName: 'tomcat.global.error'
        operator: 'GreaterThan'
        timeAggregation: 'Total'
        criterionType: 'StaticThresholdCriterion'
      }
  ]
    name: 'alert-polaris-${env}-spring-tomcat-memory'
    evaluationFrequency: 'PT5M' 
    autoMitigate: true
    scopes: [
      azurespringapp
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.AppPlatform/Spring'
    windowSize: 'PT5M'
  }
}
