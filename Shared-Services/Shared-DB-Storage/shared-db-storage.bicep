param location string 
param env string
// param lawworkspaceid string
// param lawworkspacename string


// Storage deployment 

module stgModule '../../modules/Storage/storageAccounts/stg.bicep' = {
  name: 'stg${env}'
 params: {
  name: 'stgreed${env}' 
  location: location
 }
 
}

// New STG Module test 

module blobstg '../../modules/Storage/storageAccounts/blobServices/deploy.bicep' = {
  name: 'blobstg${env}'
  params: {
    storageAccountName: 'stgreed${env}'
  }
}


// Sql Databases

module sqldb '../../modules/Databases/sql/sql.bicep' = {
  name: 'ahsqldb${env}${uniqueString(resourceGroup().id)}'
  params: {
    applicationName: 'polarisdb-${env}'
    location: location
    env: env
    tags: {
      
    }
  }
}

// // Data Factory

// module datafactory '../modules/Databases/DataFactory/factories/deploy.bicep' = {
//   name: 'datafact-deploy'
//   params: {
//     name: 'dataF-${env}'
//     location: location
//   }
// }

// module Azurespringapp '../modules/Application.platform/Azurespringapp/aspdecompile.bicep' = {
//   name: 'ASP-deployment${env}'
//   params: {
//     lawworkspaceid: lawworkspaceid
//     appInsightsName: 'appinsight-${env}-${lawworkspacename}"'
//     environment: env
//     Azure_spring_app_name: 'asp-${env}-1'
//     location: location
//   }
// }
