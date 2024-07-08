param location string = resourceGroup().location
param env string


// Storage deployment 

module stgModule '../../modules/Storage/storageAccounts/stg.bicep' = {
  name: 'AH_dev'
 params: {
  name: 'ahdev${uniqueString(resourceGroup().id)}'
  location: location
 }
}

// Sql Databases

module sqldb '../../modules/Databases/sql/sql.bicep' = {
  name: 'ahsqldb${uniqueString(resourceGroup().id)}'
  params: {
    applicationName: 'polarisdb'
    location: location
    env: env
    tags: {
      
    }
  }
}
