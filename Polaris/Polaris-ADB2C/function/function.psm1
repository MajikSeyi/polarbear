function Get-AzResourceIdIfExists(
  [Parameter(Mandatory = $true)]
  [string] $ResourceGroup,

  [Parameter(Mandatory = $true)]
  [string] $ResourceType,

  [Parameter(Mandatory = $true)]
  [string] $ResourceName
) {
  # Get the Azure resource
  $resource = Get-AzResource -ResourceGroupName $ResourceGroup -ResourceType $ResourceType -ResourceName $ResourceName -ErrorAction SilentlyContinue

  if ($resource) {
    # Return true to indicate that the resource was found
    return $resource.ResourceId
  }
  else {
    return $null
  }

}


function New-AzADB2CServicePrincipal {
  [CmdletBinding()]
  param (
      [Parameter(Mandatory = $true)]
      [string]$appId,

      [Parameter(Mandatory = $true)]
      [securestring]$accessToken
  )

  $plainAccessToken = ConvertFrom-SecureString -SecureString $accessToken -AsPlainText

  $headers = @{
      "Authorization" = "Bearer $($plainAccessToken)"
      "Content-Type"  = "application/json"
  }

  # Check if the service principal already exists
  $existingServicePrincipal = (Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/servicePrincipals" -Headers $headers -Method GET -Verbose:$false).value

  if ($existingServicePrincipal | Where-Object { $_.appId -eq $appId }) {
      Write-Host "📃  Service principal for app registration with appId $appId already exists."
      return $true, ($existingServicePrincipal | Where-Object { $_.appId -eq $appId }).id
  } else {
      $body = @{
          appId = $appId
      } | ConvertTo-Json -Depth 100

      Write-Host "📃  Creating service principal for app registration with appId $appId."
      $servicePrincipal = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/servicePrincipals" -Headers $headers -Method POST -Body $body -Verbose:$false

      if ($servicePrincipal.PSObject.Properties['error']) {
          return $false, $servicePrincipal.error
      } else {
          return $true, $servicePrincipal.id
      }
  }
}

function Set-AzADB2CAppRegistrations(
  [Parameter(Mandatory = $true)]
  [hashtable]$appRegistrations, 

  [Parameter(Mandatory = $true)]
  [securestring]$accessToken, 

  [Parameter(Mandatory = $true)]
  [string]$tenantDomain,

  [Parameter(Mandatory = $true)]
  [string]$tenantId
) {

  $plainaccessToken = ConvertFrom-SecureString -SecureString $accessToken -AsPlainText

  $headers = @{
    "Authorization" = "Bearer $($plainaccessToken)"
    "Content-Type"  = "application/json"
  }
  $appRegistrationsCurrently = (Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/applications" -Headers $headers -Method GET -SkipHttpErrorCheck -Verbose:$false).value
  $appRegistrationsContent = $appRegistrations | ConvertTo-Json -Depth 100

  if ($appRegistrationsContent) {
    if (Test-Json $appRegistrationsContent) {
      $appRegistrationsObject = $appRegistrationsContent | ConvertFrom-Json -AsHashtable
      $clientIds = @()
      $servicePrincipalIds = @()
      $appRegistrationsObject | ForEach-Object {
        if ($appRegistrationsCurrently.displayName -contains $_.displayName) {
          Write-Host "📃  Azure AD B2C app registration $($_.displayName) already exists, updating it's configuration for idempotency."
          $value = $_.displayName
          $appId = ($appRegistrationsCurrently | Where-Object { $_.displayName -eq $value }).id
          $realappId = ($appRegistrationsCurrently | Where-Object { $_.displayName -eq $value }).appId
          $appRegistrationUpdate = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/applications/$appId" -Headers $headers -Method PATCH -Body ($_ | ConvertTo-Json -Depth 100) -SkipHttpErrorCheck -Verbose:$false
          if ($appRegistrationUpdate.PSObject.Properties['error']) {
            return $false, $appRegistrationUpdate.error
          }
          else {
            $clientIds += $appId
          }
        }
        else {
          Write-Host "📃  Azure AD B2C app registration $($_.displayName) does not exist. Creating new app registration."
          $appRegistration = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/applications" -Headers $headers -Method POST -Body ($_ | ConvertTo-Json -Depth 100) -SkipHttpErrorCheck -Verbose:$false
          if ($appRegistration.PSObject.Properties['error']) {
            return $false, $appRegistration.error
          }
          else {
            $appId = $appRegistration.id
            $realappId = $appRegistration.appId
            $clientIds += $appId
            # $clientIds += $appRegistration.id
          }
        }

          # Create Service Principal
          $spResult, $spId = New-AzADB2CServicePrincipal -appId $realappId -accessToken $accessToken
          if ($spResult -eq $true) {
              $servicePrincipalIds += $spId
          } else {
              Write-Error "Error occurred while creating service principal for app registration $displayName"
          }
      }
      return $true, $clientIds
      # return $true, @{ClientIds = $clientIds; ServicePrincipalIds = $servicePrincipalIds}
    } else {
      return "Invalid JSON. Please correct this before trying again."
    }
  }
}


Export-ModuleMember -Function * -Verbose:$false
