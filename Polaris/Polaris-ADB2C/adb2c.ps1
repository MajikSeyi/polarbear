$AADB2C_PROVISION_CLIENT_ID = $env:AADB2C_PROVISION_CLIENT_ID ## Set as parameter 
$AADB2C_PROVISION_CLIENT_SECRET = $env:AADB2C_PROVISION_CLIENT_SECRET ## Set as parameter 
$env = $env:env
#
#Requires -Version 7.0.0
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$RootPath = Resolve-Path -Path (Join-Path $PSScriptRoot ".")
Import-Module (Join-Path $RootPath "function/function.psm1") -Force -Verbose:$false

# Check if GUID script exists
$guidScriptPath = "./Polaris/Polaris-ADB2C/guid.ps1"
if (-not (Test-Path $guidScriptPath)) {
    Write-Error "GUID script '$guidScriptPath' not found."
    exit 1
}

# Run the GUID script
& $guidScriptPath


if ($? -eq $false) {
  Write-Error "GUID script '$guidScriptPath' failed to run."
  exit 1
}

$context = Get-Content -Path "./Polaris/Polaris-ADB2C/$($env)-config.json" | ConvertFrom-Json -AsHashtable 

Write-Verbose "Executing Azure AD B2C script with the following context:"
Write-Verbose ($context | Format-Table | Out-String)

try {

  $parameters = @{
    # tags                  = @{ purpose = 'Azure AD B2C App' }
    azureADB2Cname        = $context.AzureADB2C.domainName
    azureADB2CDisplayName = $context.AzureADB2C.displayName
    skuName               = $context.AzureADB2C.skuName
    skuTier               = $context.AzureADB2C.skuTier
    countryCode           = $context.AzureADB2C.countryCode
    location_b2c          = $context.AzureADB2C.location
  }


  ###################################
  # Deploy Azure AD B2C
  ###################################

  $ifAlreadyExists = Get-AzResourceIdIfExists -ResourceGroup $context.AzureADB2C.resourceGroup -ResourceType 'Microsoft.AzureActiveDirectory/b2cDirectories' -ResourceName $context.AzureADB2C.domainName
 
            

  

if (-not [string]::IsNullOrEmpty($AADB2C_PROVISION_CLIENT_ID) -and -not [string]::IsNullOrEmpty($AADB2C_PROVISION_CLIENT_SECRET)) { 
# If post-deployment step to create provisioning app registration client id and secret has been done, configure Azure AD B2C end-to-end (except application claim flows)

$domainName = $context.AzureADB2C.domainName
$clientId = $AADB2C_PROVISION_CLIENT_ID
$clientSecret = $AADB2C_PROVISION_CLIENT_SECRET
$scope = "https://graph.microsoft.com/.default"
    
$body = @{
    grant_type    = "client_credentials"
    client_id     = $clientId
    client_secret = $clientSecret
    scope         = $scope
}
    
Write-Host "📃 Obtaining token to manage Azure AD B2C tenancy $domainName"
$response = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$domainName/oauth2/v2.0/token" -Method POST -Body $body -SkipHttpErrorCheck -Verbose:$false
    
if ($response.PSObject.Properties['error']) {
    Write-Warning "⚠️  Please ensure you have followed post-deployment instructions to configure the appropriate app registration to manage this tenancy and confirm the secret has not expired. `r`n"
    throw $response.error_description
}
else {
    $accessToken = $response.access_token
    $secureAccessToken = ConvertTo-SecureString -String $accessToken -AsPlainText -Force

    $headers = @{
    "Authorization" = "Bearer $($accessToken)"
    "Content-Type"  = "application/json"
    }

    $tenantId = (Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/organization" -Headers $headers -Method GET -SkipHttpErrorCheck -Verbose:$false).value.id
    
    
    # Azure App Registrations
    if ($context.AzureADB2C.Contains('appRegistrations')) {
    $results = foreach ($appRegistration in $context.AzureADB2C.appRegistrations) {
        $result, $clientIds = Set-AzADB2CAppRegistrations -accessToken $secureAccessToken -appRegistration $appRegistration -tenantId $tenantId -tenantDomain $context.AzureADB2C.domainName
        [PSCustomObject]@{
          Result = $result
          ClientIds = $clientIds
        }
    }
    if ($result -eq $true) {
        "✅  Successfully created/Updated Azure AD B2C app registrations and service principals $($context.AzureADB2C.appRegistrations.displayName)"
    }
    else {
        Write-Error "Creation/Update of App-registration failed and service principals"
    }
    }
#
    $deploymentOutputs += @{ 'azureADB2C_Config' = @{ 
        Type  = "Object"
        Value = @{
        tenantId       = $tenantId
        domainName     = $domainName
        knownAuthority = "$(($context.AzureADB2C.domainName).split(".")[0]).b2clogin.com"
        issuer         = "https://$(($context.AzureADB2C.domainName).split(".")[0]).b2clogin.com/$tenantId/v2.0/"
        clientId       = $clientIds[0]
        }
    } 
    }
}
}
else {
Write-Warning "⚠️ ClientId and ClientSecret for Azure AD B2C tenancy $($context.AzureADB2C.domainName) not provided. Please ensure to follow the post-deployment step to create the app registration in order to correctly configure AAD B2C for this solution."
# If post-deployment step to create provisioning app registration client id and secret has been done, configure Azure AD B2C end-to-end (except application claim flows)

$deploymentOutputs += @{ 'azureADB2C_Config' = @{
    Type  = "Object"
    Value = @{
        domainName = $context.AzureADB2C.domainName
    }
   } 
 }
}             
  

  ####################################
  # Publish output variables
  ###################################

  if ($deploymentOutputs) {
    $deploymentOutputs.GetEnumerator() | ForEach-Object {
      Write-Output "$($_.Key)=$($_.Value.value)" >> $env:GITHUB_OUTPUT
    }
  }
}

catch {
  throw $_
}