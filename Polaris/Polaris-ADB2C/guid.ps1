# GUID.ps1

# Check if config.json exists
$configFilePath = "./Polaris/Polaris-ADB2C/$($env)-config.json"
if (-not (Test-Path $configFilePath)) {
    Write-Error "Config file '$configFilePath' not found."
    exit 1
}

try {
    # Read the JSON content from the config.json file
    $jsonContent = Get-Content -Raw -Path $configFilePath | ConvertFrom-Json

    # Check if JSON content is valid
    if (-not $jsonContent) {
        Write-Error "Failed to read JSON content from '$configFilePath'."
        exit 1
    }

    # Check if 'AzureADB2C' property exists and contains 'appRegistrations'
    if (-not ($jsonContent.AzureADB2C -and $jsonContent.AzureADB2C.appRegistrations)) {
        Write-Error "Invalid or missing 'AzureADB2C.appRegistrations' property in '$configFilePath'."
        exit 1
    }

    # Generate GUIDs for empty scope IDs and AppIds
    $updated = $false
    foreach ($appRegistration in $jsonContent.AzureADB2C.appRegistrations) {
        foreach ($scope in $appRegistration.api.oauth2PermissionScopes) {
            if ([string]::IsNullOrEmpty($scope.id)) {
                $newGuid = [guid]::NewGuid().ToString()
                $scope.id = $newGuid
                Write-Host "Generated new GUID '$newGuid' for $($appRegistration.displayName)"
                $updated = $true
            } else {
                Write-Host "GUID already filled for $($appRegistration.displayName)"
            }
        }
    }

    

    if ($updated) {
        # Convert the updated object back to JSON and save it to the file
        $jsonContent | ConvertTo-Json -Depth 100 | Set-Content -Path $configFilePath
        Write-Host "GUIDs and appIDs updated in '$configFilePath'"
        Write-Host "Remember to update the GUIDs and appIDs manually if needed"
    } else {
        Write-Host "No empty scope IDs or appIDs found in '$configFilePath'."
    }

} catch {
    Write-Error "An error occurred: $_"
    exit 1
}
