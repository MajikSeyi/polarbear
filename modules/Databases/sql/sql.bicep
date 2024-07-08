// App Service - Bicep module
// Generated by NubesGen (www.nubesgen.com)

// Module requirements
// Serverless tier or General Purpose GP_Gen5_2
// Outputs: database URL, username & password
// Check integration with App Service + Key Vault

@description('The name of your application')
param applicationName string

@description('The environment (dev, test, prod, ...')
@maxLength(4)
param env string

@description('The number of this specific instance')
@maxLength(3)
param instanceNumber string = '001'

@description('The Azure region where all resources in this example should be created')
param location string 

@description('A list of tags to apply to the resources')
param tags object

@description('The name of the SQL logical server.')
param serverName string = 'sql-${applicationName}-${env}-${instanceNumber}'

@description('The name of the SQL Database.')
param sqlDBName string = applicationName

@description('The administrator username of the SQL logical server.')
param administratorLogin string = 'sql${replace(applicationName, '-', '')}root'

@description('The administrator password of the SQL logical server.')
@secure()
param administratorLoginPassword string = newGuid()

resource serverName_resource 'Microsoft.Sql/servers@2020-02-02-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

resource serverName_sqlDBName 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  parent: serverName_resource
  name: sqlDBName
  location: location
  tags: tags
  sku: {
    name: 'GP_S_Gen5_1'
  }
  properties: {
    autoPauseDelay: 60
    collation: 'SQL_Latin1_General_CP1_CI_AS'

  }
}

resource threatprotect 'Microsoft.Sql/servers/databases/advancedThreatProtectionSettings@2022-05-01-preview' = {
  name: 'Default'
  parent: serverName_sqlDBName
  properties: {
    state: 'Enabled'
  }
}


// Outputs: database URL, username & password
