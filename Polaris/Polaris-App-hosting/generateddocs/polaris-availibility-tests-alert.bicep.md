# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
name           | Yes      | Required. The name of the alert.
alertDescription | No       | Optional. Description of the alert.
location       | No       | Optional. Location for all resources.
enabled        | Yes      | Optional. Indicates whether this alert is enabled.
severity       | Yes      | Optional. The severity of the alert.
evaluationFrequency | Yes      | Optional. how often the metric alert is evaluated represented in ISO 8601 duration format.
windowSize     | Yes      | Optional. the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold.
scopes         | Yes      | Optional. the list of resource IDs that this metric alert is scoped to.
targetResourceType | No       | Conditional. The resource type of the target resource(s) on which the alert is created/updated. Required if alertCriteriaType is MultipleResourceMultipleMetricCriteria.
targetResourceRegion | No       | Conditional. The region of the target resource(s) on which the alert is created/updated. Required if alertCriteriaType is MultipleResourceMultipleMetricCriteria.
autoMitigate   | Yes      | Optional. The flag that indicates whether the alert should be auto resolved or not.
actions        | No       | Optional. The list of actions to take when alert triggers.
alertCriteriaType | Yes      | Optional. Maps to the 'odata.type' field. Specifies the type of the alert criteria.
criterias      | Yes      | Required. Criterias to trigger the alert. Array of 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria' or 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria' objects.
roleAssignments | No       | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.
tags           | No       | Optional. Tags of the resource.
enableDefaultTelemetry | No       | Optional. Enable telemetry via a Globally Unique Identifier (GUID).

### name

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. The name of the alert.

### alertDescription

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Description of the alert.

### location

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Location for all resources.

- Default value: `global`

### enabled

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. Indicates whether this alert is enabled.

### severity

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. The severity of the alert.

- Allowed values: `0`, `1`, `2`, `3`, `4`

### evaluationFrequency

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. how often the metric alert is evaluated represented in ISO 8601 duration format.

- Allowed values: `PT1M`, `PT5M`, `PT15M`, `PT30M`, `PT1H`

### windowSize

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold.

- Allowed values: `PT1M`, `PT5M`, `PT15M`, `PT30M`, `PT1H`, `PT6H`, `PT12H`, `P1D`

### scopes

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. the list of resource IDs that this metric alert is scoped to.

### targetResourceType

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Conditional. The resource type of the target resource(s) on which the alert is created/updated. Required if alertCriteriaType is MultipleResourceMultipleMetricCriteria.

### targetResourceRegion

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Conditional. The region of the target resource(s) on which the alert is created/updated. Required if alertCriteriaType is MultipleResourceMultipleMetricCriteria.

### autoMitigate

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. The flag that indicates whether the alert should be auto resolved or not.

### actions

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The list of actions to take when alert triggers.

### alertCriteriaType

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. Maps to the 'odata.type' field. Specifies the type of the alert criteria.

- Allowed values: `Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria`, `Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria`, `Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria`

### criterias

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Criterias to trigger the alert. Array of 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria' or 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria' objects.

### roleAssignments

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

### tags

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Tags of the resource.

### enableDefaultTelemetry

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Enable telemetry via a Globally Unique Identifier (GUID).

- Default value: `True`

## Outputs

Name | Type | Description
---- | ---- | -----------
resourceGroupName | string | The resource group the metric alert was deployed into.
name | string | The name of the metric alert.
resourceId | string | The resource ID of the metric alert.
location | string | The location the resource was deployed into.

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Polaris/Polaris-App-hosting/polaris-availibility-tests-alert.json"
    },
    "parameters": {
        "name": {
            "value": ""
        },
        "alertDescription": {
            "value": ""
        },
        "location": {
            "value": "global"
        },
        "enabled": {
            "value": null
        },
        "severity": {
            "value": 0
        },
        "evaluationFrequency": {
            "value": ""
        },
        "windowSize": {
            "value": ""
        },
        "scopes": {
            "value": []
        },
        "targetResourceType": {
            "value": ""
        },
        "targetResourceRegion": {
            "value": ""
        },
        "autoMitigate": {
            "value": null
        },
        "actions": {
            "value": []
        },
        "alertCriteriaType": {
            "value": ""
        },
        "criterias": {
            "value": {}
        },
        "roleAssignments": {
            "value": []
        },
        "tags": {
            "value": {}
        },
        "enableDefaultTelemetry": {
            "value": true
        }
    }
}
```
