param utcValue string = utcNow()
param location string = resourceGroup().location
param ps1location string = loadTextContent('../Application.platform/stopspring.ps1')

resource runPowerShellInlineWithOutput 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'runPowerShellInlineWithOutput'
  location: location
  kind: 'AzurePowerShell'
  properties: {
    forceUpdateTag: utcValue
    azPowerShellVersion: '8.3'
    scriptContent: '''
    param([string] $ps1location)
    New-Item -Path . -Name "runbook.ps1" -ItemType "file" -Value \'${ps1location}\'
    $automationAccountName = "automation-polaris-test-uksouth" 
    $runbookName = "TestRunbook"

    Import-AzAutomationRunbook -Path runbook.ps1 -Tags $Tags -ResourceGroupName "rg-automation" -AutomationAccountName $automationAccountName -Type Powershell
    Publish-AzAutomationRunbook -AutomationAccountName $automationAccountName -Name $runbookName -ResourceGroupName "rg-automation"
        '''
    arguments: '-value \'${ps1location}\''
    timeout: 'PT1H'
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
  }
}
