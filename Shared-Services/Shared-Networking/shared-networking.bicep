targetScope =  'subscription'



param tstenv string 
param envshared string = 'shared'
param rg_shared_monitoring string 
param ukslocation string 

param plspringapplbnametst string 
param plspringapplbnameuat string 
param plspringapplbnametrn string
param plspringapplbnameprod string 

param sharedmonitorsubscription string
param rg_virtual_network string
param sharedgateway string

param tstrgvirtualnetworking string
param tstsubscription string

param uatrgvirtualnetworking string
param uatsubscription string

param trnrgvirtualnetworking string
param trnsubscription string

param prodrgvirtualnetworking string
param prodsubscription string

param waftstname string
param wafuatname string
param waftrnname string
param wafprodname string


param IPAllowListTEST array
param IPAllowListUAT array
param IPAllowListTRN array
param IPAllowListPROD array
// param vnetaddressPrefixes array
// param PolarisVnetDataGWSubnet string

//// Dependancys //// 


resource plspringapplb 'Microsoft.Network/privateLinkServices@2022-09-01' existing = {
  name: plspringapplbnametst 
  scope: resourceGroup(tstsubscription, tstrgvirtualnetworking)
}  

resource plspringapplbuat 'Microsoft.Network/privateLinkServices@2022-09-01' existing = {
  name: plspringapplbnameuat
  scope: resourceGroup(uatsubscription, uatrgvirtualnetworking)
}  

resource plspringapplbtrn 'Microsoft.Network/privateLinkServices@2022-09-01' existing = {
  name: plspringapplbnametrn
  scope: resourceGroup(trnsubscription, trnrgvirtualnetworking)
}  

resource plspringapplbprod 'Microsoft.Network/privateLinkServices@2022-09-01' existing = {
  name: plspringapplbnameprod
  scope: resourceGroup(prodsubscription, prodrgvirtualnetworking)
}  

//LAW
module law '../../Shared-Services/Shared-Monitoring/shared-monitoring.bicep'  = {
  name: 'lawop${tstenv}${uniqueString(deployment().name)}-001'
  params: {
    sharedmonitorsubscription: sharedmonitorsubscription
    sharedenv: envshared
    rg_shared_monitoring: rg_shared_monitoring 
    ukslocation: ukslocation
  }
}

resource lawaudit 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: 'm365azuresentinel-dw-prod-uks-la'
  scope: resourceGroup('e7fe7e3e-7874-4903-87be-422595a82d07','it-dw-sentinel-logs-production-rg' )
}

// Deployed into new Subscription

module virtualnetworkrg '../../modules/Resources/resourceGroups/rg.bicep' = {
  name: '${uniqueString(deployment().name)}-vnet-shared-rg'
  scope: subscription(sharedgateway)
  params: {
    name: rg_virtual_network
    location: ukslocation
  }
}


//// Create and deploy AFD
module afddeployv3  '../../modules/Networking/frontDoors/afdv3.bicep' = {
  scope: resourceGroup('rg-frontdoor')
  name: '${uniqueString(deployment().name)}-afd' 
  params: {
    wafpolaristestid: afdwaf.outputs.wafpolicyidtest
    wafpolarisuatid: afdwaf.outputs.wafpolicytiduat
    wafpolaristrnid: afdwaf.outputs.wafpolicyidtrn
    wafpolarisprodid: afdwaf.outputs.wafpolicyidprod
    diagnosticWorkspaceId: law.outputs.lawop
    diagnosticWorkspaceIdAudit: lawaudit.id
    profiles_afd_name: 'afd-shared-production'
    privateLinkServices_pl_springapps_polaris_test_externalid: plspringapplb.id
    privateLinkServices_pl_springapps_polaris_uat_externalid: plspringapplbuat.id
    privateLinkServices_pl_springapps_polaris_trn_externalid: plspringapplbtrn.id
    privateLinkServices_pl_springapps_polaris_prod_externalid: plspringapplbprod.id
  }
}

module afdwaf '../../modules/Networking/frontDoors/afdwafrules.bicep' = {
  scope: resourceGroup('rg-frontdoor') 
  name: '${uniqueString(deployment().name)}-afdwafrules-${envshared}'  
  params: {    
    IPAllowListTEST: IPAllowListTEST
    IPAllowListUAT: IPAllowListUAT
    IPAllowListTRN: IPAllowListTRN
    IPAllowListPROD: IPAllowListPROD
    waf_tst_name: waftstname 
    waf_uat_name: wafuatname
    waf_trn_name: waftrnname
    waf_prod_name: wafprodname 

  }
}



