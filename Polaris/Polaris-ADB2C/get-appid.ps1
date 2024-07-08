# Initialize variables from environment
$AADB2C_PROVISION_CLIENT_ID = $env:AADB2C_PROVISION_CLIENT_ID
$AADB2C_PROVISION_CLIENT_SECRET = $env:AADB2C_PROVISION_CLIENT_SECRET
$env = $env:env

# Define the authentication scope for Graph API
$scope = "https://graph.microsoft.com/.default"

$context = Get-Content -Path "./Polaris/Polaris-ADB2C/$($env)-config.json" | ConvertFrom-Json -AsHashtable 

# Get OAuth token
try {
    $body = @{
        grant_type    = "client_credentials"
        client_id     = $AADB2C_PROVISION_CLIENT_ID
        client_secret = $AADB2C_PROVISION_CLIENT_SECRET
        scope         = $scope
    }

    $tokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$($context.AzureADB2C.domainName)/oauth2/v2.0/token" -Method POST -Body $body -ErrorAction Stop
    $accessToken = $tokenResponse.access_token
}
catch {
    throw "Failed to acquire access token: $_"
}

# Set headers for subsequent Graph API calls
$headers = @{
    "Authorization" = "Bearer $($accessToken)"
    "Content-Type"  = "application/json"
}

# Verify existence of config file
$configFilePath = "./Polaris/Polaris-ADB2C/$($env)-config.json"
if (-not (Test-Path $configFilePath)) {
    throw "Config file '$configFilePath' not found."
}

# Load configuration JSON
try {
    $jsonContent = Get-Content -Raw -Path $configFilePath | ConvertFrom-Json
}
catch {
    throw "Failed to load or parse the configuration file: $_"
}

try {
    $appRegistrationsCurrently = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/applications" -Headers $headers -Method GET -ErrorAction Stop
}
catch {
    throw "Failed to retrieve application data from Microsoft Graph: $_"
}

# Variables to hold special App Registration details
$identityFrameworkAppId = $null
$identityFrameworkOAuthScopeId = $null

# First pass to capture IdentityExperienceFramework details
foreach ($app in $appRegistrationsCurrently.value) {
    if ($app.displayName -eq "IdentityExperienceFramework") {
        $identityFrameworkAppId = $app.appId
        $identityFrameworkOAuthScopeId = ($jsonContent.AzureADB2C.appRegistrations | Where-Object {$_.displayName -eq "IdentityExperienceFramework"}).api.oauth2PermissionScopes[0].id
    }
}

# Second pass to apply logic
foreach ($appRegistration in $jsonContent.AzureADB2C.appRegistrations) {
    $appId = ($appRegistrationsCurrently.value | Where-Object { $_.displayName -eq $appRegistration.displayName }).appId
    if (!$appId) {
        Write-Warning "No app ID found for $($appRegistration.displayName)"
        continue
    }

    # Skip processing for normal apps under certain conditions, not for special apps
    if (($appRegistration.displayName -ne "IdentityExperienceFramework Proxy") -and
        ($appRegistration.api.oauth2PermissionScopes.Count -eq 0 -or $appRegistration.requiredResourceAccess.Count -gt 1)) {
        Write-Host "Skipping $($appRegistration.displayName) due to normal conditions."
        continue
    }

    # Ensure no changes to IdentityExperienceFramework unless explicitly intended
    if ($appRegistration.displayName -eq "IdentityExperienceFramework") {
        Write-Host "No updates applied to IdentityExperienceFramework based on requirements."
        continue
    }

    # Special handling for IdentityExperienceFramework Proxy
    if ($appRegistration.displayName -eq "IdentityExperienceFramework Proxy") {
        if ($identityFrameworkAppId -and $identityFrameworkOAuthScopeId) {
            $existingResourceAccess = $appRegistration.requiredResourceAccess | Where-Object { $_.resourceAppId -eq $identityFrameworkAppId }

            if (-not $existingResourceAccess) {
                $appRegistration.requiredResourceAccess += [ordered]@{
                    resourceAppId  = $identityFrameworkAppId
                    resourceAccess = @(
                        @{
                            id   = $identityFrameworkOAuthScopeId
                            type = "Scope"
                        }
                    )
                }
                Write-Host "Updated IdentityExperienceFrameworkProxy with IdentityExperienceFramework settings."
            } else {
                Write-Host "IdentityExperienceFramework settings already present in IdentityExperienceFrameworkProxy."
            }
        } else {
            Write-Warning "IdentityExperienceFramework details not found."
        }
        continue
    }
    # Normal processing for other applications here...
    # Retrieve application ID from Graph API
    $appRegistrationsCurrently = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/applications" -Headers $headers -Method GET -ErrorAction Stop
    $appId = ($appRegistrationsCurrently.value | Where-Object { $_.displayName -eq $appRegistration.displayName }).appId

    if (-not $appId) {
        Write-Warning "Application $($appRegistration.displayName) not found."
        continue
    }

    Write-Host "Processing application with ID: $appId"

    # Define the resource access based on existing IDs
    $orderedResourceAccess = [ordered]@{
        id   = $appRegistration.api.oauth2PermissionScopes[0].id
        type = "Scope"
                        
    }            
    # Define the ordered properties for the new resource access
    $newResourceAccess = [ordered]@{
        resourceAppId  = $appId
        resourceAccess = @($orderedResourceAccess)
    }

    # Update the JSON object in memory
    $appRegistration.requiredResourceAccess += $newResourceAccess
    Write-Host "Updated resource access for application $($appRegistration.displayName)."
    Write-Host "Processing $($appRegistration.displayName) under normal conditions."
}

# Save the updated configuration
try {
    $jsonContent | ConvertTo-Json -Depth 100 | Set-Content -Path $configFilePath
    Write-Host "Updated configuration saved to '$configFilePath'."
}
catch {
    throw "Failed to save the updated configuration: $_"
}
