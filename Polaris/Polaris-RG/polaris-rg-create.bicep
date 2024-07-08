targetScope = 'subscription'


// Param ////
@description('The resource group for the Virtual Network.')
param rg_virtualnetwork string

@description('The resource group for the Spring application.')
param rg_springapp string

@description('The resource group for the Spring app runtime.')
param rg_springapp_runtime string

@description('The resource group for the Spring applications.')
param rg_springapp_apps string 

@description('The resource group for the private endpoint.')
param rg_privateendpoint string

@description('The resource group for the static web application.')
param rg_staticwebapps string 

@description('The resource group for the sql server.')
param rg_sqlserver string

@description('The resource group for the document storage.')
param rg_documentstorage string

@description('The resource group for the automation.')
param rg_automation string

@description('The resource group for the redis cache.')
param rg_rediscache string

@description('The resource group for the directus.')
param rg_directus string

@description('The resource group for the directus storage.')
param rg_directusstorage string

@description('The resource group for the Azure Active Directory B2C.')
param rg_adb2c string

@description('The resource group for the UK south location.')
param ukslocation string

@description('The resource group for the malware scanning.')
param rg_malwarescanning string

@description('The resource group for the Data Factory.')
param rg_datafactory string

@description('The resource group for the Dashboards')
param rg_dashboards string

@description('checks if the resource group already exists')
param rgresourceExists bool


// rg-virtual-networking
module rgvirtualnetwork '../../modules/Resources/resourceGroups/rg.bicep'  = {
  name: '${uniqueString(deployment().name)}-vnet-rg'
  params: {
    name: rg_virtualnetwork
    location: ukslocation
  }
}

// rg-springapps
module rgspringapp '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-spring-rg'
  params: {
    name: rg_springapp
    location: ukslocation
  }
}


// rg-springapps-runtime-networking
module rgspringappruntime '../../modules/Resources/resourceGroups/rg.bicep' = if (!rgresourceExists) {
  name: '${uniqueString(deployment().name)}-runtime-rg'
  params: {
    name: rg_springapp_runtime
    location: ukslocation
  }
}


// rg-springapps-apps-networking
module rgspringappapplication '../../modules/Resources/resourceGroups/rg.bicep' = if (!rgresourceExists) {
  name: '${uniqueString(deployment().name)}-app-rg'
  params: {
    name: rg_springapp_apps
    location: ukslocation
  }
}


// rg-privateendpoints 
module rgprivateendpoint '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-privateend-rg'
  params: {
    name: rg_privateendpoint
    location: ukslocation
  }
}

// rg-staticwebapps
module rgstaticwebapps '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-static-rg'
  params: {
    name: rg_staticwebapps
    location: ukslocation
  }
}

// rg-sqlserver
module rgsqlserver '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-sql-rg'
  params: {
    name: rg_sqlserver
    location: ukslocation
  }
}

// rg-documentstorage
module rgdocumentstorage '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-stg-rg'
  params: {
    name: rg_documentstorage
    location: ukslocation
  }
}

// rg-automation
module rgautomation '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-automate-rg'
  params: {
    name: rg_automation
    location: ukslocation
  }
}

// rg-rediscache
module rediscache '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-redisccache-rg'
  params: {
    name: rg_rediscache
    location: ukslocation
  }
}

// rg-directus
module directus '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-directus-rg'
  params: {
    name: rg_directus
    location: ukslocation
  }
}

// rg-directusstorage
module directusstg '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-directusstg-rg'
  params: {
    name: rg_directusstorage
    location: ukslocation
  }
}


// rg-adb2c
module adb2c '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-adb2c-rg'
  params: {
    name: rg_adb2c
    location: ukslocation
  }
}

// rg-malwarescanning
module malwarescanning '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-malware-rg'
  params: {
    name: rg_malwarescanning
    location: ukslocation
  }
}


// rg-datafactory
module datafactory '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-datafactory-rg'
  params: {
    name: rg_datafactory
    location: ukslocation
  }
}

//rg-dashboards

module dashboards '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-dashboards-rg'
  params: {
    name: rg_dashboards
    location: ukslocation
  }
}
