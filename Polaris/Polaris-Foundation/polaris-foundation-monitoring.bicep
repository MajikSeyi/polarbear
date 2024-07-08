targetScope = 'subscription'


//// Parameters ////
@description('Specifies the value of the secret that you want to create.')
@secure()

param rg_sqlserver string // rg-sqlserver
param rg_shared_monitoring string //
param sqldatabase string
param ukslocation string //uksouth
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



// References



/////////////////////////////
//// Resource Monitoring ////
/////////////////////////////


//// Action groups //// 

// Spring apps - Action Group
module actionGroups '../../modules/Microsoft.Insights/actionGroups/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-iagcom'
  scope: resourceGroup(rg_sqlserver)
  params: {
    // Required parameters
    groupShortName: 'polaris-${env}'
    name: 'ag-polaris-${env}-sql'
    // Non-required parameters
    emailReceivers: [
      {
        emailAddress: 'sqldbas@reed.com'
        name: 'SQL DBA'
        useCommonAlertSchema: true
      }
    ]
  }
}


// SQL App Memory Percent - Metric

module sqlappmemeorymetricAlerts '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = if (env != 'prod') {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-sqlmetricmemory'
  scope: resourceGroup(rg_sqlserver)
  params: {
    // Required parameters
    criterias: [
      {
        alertSensitivity: 'Medium'
        name: 'alert-polaris-${env}-sql-db-memory-utilisation'
        metricNamespace: 'Microsoft.Sql/servers/databases'
        metricName: 'app_memory_percent'
        operator: 'GreaterThanOrEqual'
        timeAggregation: 'Average'
        skipMetricValidation: false
        criterionType: 'StaticThresholdCriterion'
        threshold: 90
    }
    ]
    name: 'alert-polaris-${env}-sql-db-memory-utilisation'
    severity: 2
    evaluationFrequency: 'PT5M' 
    autoMitigate: true
    scopes: [
      sqldatabase
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.Sql/servers/databases'
    windowSize: 'PT5M'
  }
}

// SQL App CPU percentage(Max)/CPU Used - Metric

module sqlaveragecpumetricAlerts '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = if (env != 'prod') {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-sqlmetriccpu'
  scope: resourceGroup(rg_sqlserver)
  params: {
    // Required parameters
    criterias: [
      {
        alertSensitivity: 'Medium'
        name: 'alert-polaris-${env}-sql-db-cpu-utilisation'
        metricNamespace: 'Microsoft.Sql/servers/databases'
        metricName: 'app_cpu_percent'
        operator: 'GreaterThan'
        timeAggregation: 'Maximum'
        skipMetricValidation: false
        criterionType: 'DynamicThresholdCriterion'
        threshold: 90
        failingPeriods: {
          numberOfEvaluationPeriods: 4
          minFailingPeriodsToAlert: 4
      }
    }
    ]
    name: 'alert-polaris-${env}-sql-db-cpu-utilisation'
    severity: 2
    evaluationFrequency: 'PT5M' 
    autoMitigate: true
    scopes: [
      sqldatabase
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.Sql/servers/databases'
    windowSize: 'PT5M'
  }
}

// SQL Successful connections - Metric

module sqlsuccessconnectionmetricAlerts '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-connectionsqlmetric'
  scope: resourceGroup(rg_sqlserver)
  params: {
    // Required parameters
    criterias: [
      {
        alertSensitivity: 'Low'
        failingPeriods: {
          numberOfEvaluationPeriods: 4
          minFailingPeriodsToAlert: 4
        }
        name: 'alert-polaris-${env}-sql-db-success-connections'
        metricNamespace: 'Microsoft.Sql/servers/databases'
        metricName: 'connection_successful'
        operator: 'GreaterOrLessThan'
        timeAggregation: 'Total'
        skipMetricValidation: false
        criterionType: 'DynamicThresholdCriterion'
    }
    ]
    severity: 3
    name: 'alert-polaris-${env}-sql-db-success-connections'
    evaluationFrequency: 'PT1H' 
    autoMitigate: true
    scopes: [
      sqldatabase
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.Sql/servers/databases'
    windowSize: 'PT1H'
  }
}

// SQL Failed connections - Alert

module sqlfailedconnectionmetricAlerts '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-failedconnectionsqlmetric'
  scope: resourceGroup(rg_sqlserver)
  params: {
    // Required parameters
    criterias: [
      {
        alertSensitivity: 'Low'
        name: 'alert-polaris-${env}-sql-db-failed-sessions'
        metricNamespace: 'Microsoft.Sql/servers/databases'
        metricName: 'connection_failed'
        operator: 'GreaterThan'
        timeAggregation: 'Total'
        skipMetricValidation: false
        criterionType: 'StaticThresholdCriterion'
        threshold: 5
    }
    ]
    severity: 0
    name: 'alert-polaris-${env}-sql-db-failed-sessions'
    evaluationFrequency: 'PT1M' 
    autoMitigate: true
    scopes: [
      sqldatabase
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.Sql/servers/databases'
    windowSize: 'PT5M'
  }
}

// SQL Max connections - Alert

module sqlmaxsessions '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}maxsessionssqlmetric'
  scope: resourceGroup(rg_sqlserver)
  params: {
    // Required parameters
    criterias: [
      {
        name: 'alert-polaris-${env}-sql-db-max-sessions'
        metricNamespace: 'Microsoft.Sql/servers/databases'
        metricName: 'sessions_percent'
        operator: 'GreaterThan'
        timeAggregation: 'Average'
        skipMetricValidation: false
        criterionType: 'StaticThresholdCriterion'
        threshold: 95
    }
    ]
    severity: 0
    name: 'alert-polaris-${env}-sql-db-max-sessions'
    evaluationFrequency: 'PT1M' 
    autoMitigate: true
    scopes: [
      sqldatabase
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.Sql/servers/databases'
    windowSize: 'PT5M'
  }
}

// SQL DB Max Used

module sqlsqldbalertdataspaced '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}sqldbspaceused'
  scope: resourceGroup(rg_sqlserver)
  params: {
    // Required parameters
    criterias: [
      {
        name: 'alert-polaris-${env}-sql-db-data-space-useds'
        metricNamespace: 'Microsoft.Sql/servers/databases'
        metricName: 'storage_percent'
        operator: 'GreaterThan'
        timeAggregation: 'Maximum'
        skipMetricValidation: false
        criterionType: 'StaticThresholdCriterion'
        threshold: 95
    }
    ]
    severity: 2
    name: 'alert-polaris-${env}-sql-db-data-space-used'
    evaluationFrequency: 'PT5M' 
    autoMitigate: true
    scopes: [
      sqldatabase
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.Sql/servers/databases'
    windowSize: 'PT5M'
  }
}

// SQL TempDB data logs

module sqlsqltempbdlogused '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}sqltempdbdatalog'
  scope: resourceGroup(rg_sqlserver)
  params: {
    // Required parameters
    criterias: [
      {
        name: 'alert-polaris-${env}-sql-db-temp-space-used'
        metricNamespace: 'Microsoft.Sql/servers/databases'
        metricName: 'tempdb_log_used_percent'
        operator: 'GreaterThan'
        timeAggregation: 'Maximum'
        skipMetricValidation: false
        criterionType: 'StaticThresholdCriterion'
        threshold: 95
    }
    ]
    severity: 2
    name: 'alert-polaris-${env}-sql-db-temp-space-used'
    evaluationFrequency: 'PT5M' 
    autoMitigate: true
    scopes: [
      sqldatabase
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.Sql/servers/databases'
    windowSize: 'PT5M'
  }
}





// SQL App O/I- Data/Logs - Metric

module sqliodatalogsmetric '../../modules/Microsoft.Insights/metricAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-sqlmetriciodatalog'
  scope: resourceGroup(rg_sqlserver)
  params: {
    // Required parameters
    criterias: [
      {
        threshold: 90
        name: 'Metric1'
        metricNamespace: 'microsoft.sql/servers/databases'
        metricName: 'physical_data_read_percent'
        operator: 'GreaterThan'
        timeAggregation: 'Average'
        criterionType: 'StaticThresholdCriterion'
      }
      {
        threshold: 90
        name: 'Metric2'
        metricNamespace: 'microsoft.sql/servers/databases'
        metricName: 'log_write_percent'
        operator: 'GreaterThan'
        timeAggregation: 'Average'
        criterionType: 'StaticThresholdCriterion'
      }

    ]
    name: 'alert-polaris-${env}-sql-db-data-io'
    severity: 2
    evaluationFrequency: 'PT5M' 
    autoMitigate: true
    scopes: [
      sqldatabase
    ]
    actions: [
      actionGroups.outputs.resourceId
    ]
    alertCriteriaType: 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    targetResourceRegion: 'uksouth'
    targetResourceType: 'Microsoft.Sql/servers/databases'
    windowSize: 'PT5M'
  }
}


// Spring apps- activitlylog - Critical stop

module activityLogAlertspringapps '../../modules/Microsoft.Insights/activityLogAlerts/deploy.bicep' = {
  name: '${uniqueString(deployment().name, ukslocation)}-${env}-resourcehealth'
  scope: resourceGroup(rg_sqlserver)
  params: {
    // Required parameters
    conditions: [
      {
        field: 'category'
        equals: 'ResourceHealth'
      }
      {
        anyOf: [
          {
            field: 'properties.cause'
            equals: 'PlatformInitiated'
          }
        ]
      }
      {
        anyOf: [
          {
            field: 'properties.currentHealthStatus'
            equals: 'Degraded'
          }
          {
            field: 'properties.currentHealthStatus'
            equals: 'Unavailable'
          }
        ]
      }
      {
        anyOf: [
          {
            field: 'properties.previousHealthStatus'
            equals: 'Degraded'
          }
          {
            field: 'properties.previousHealthStatus'
            equals: 'Unavailable'
          }
          {
            field: 'properties.previousHealthStatus'
            equals: 'Unknown'
          }
        ]
      }
    ]
    name: 'alert-polaris-${env}-service-health'
    actions: [
      {
        actionGroupId: actionGroups.outputs.resourceId
      }
    ]
    scopes: [
      sqldatabase
    ]
  }
}
