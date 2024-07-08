@description('Required - default to PremiumP2')
param skuname string = 'PremiumP2'
@description('Required - default A0')
param skutier string = 'A0'
param location string = 'europe'
param b2cname string = 'reedpolaristest1.onmicrosoft.com'
param tenantdisplayname string

resource b2cdeployment 'Microsoft.AzureActiveDirectory/b2cDirectories@2021-04-01' = {
  name: b2cname
  location: location
  sku: {
    name: skuname
    tier: skutier
  }
  properties: {
    createTenantProperties: {
      countryCode: 'GB'
      displayName: tenantdisplayname
    }
  }
}
