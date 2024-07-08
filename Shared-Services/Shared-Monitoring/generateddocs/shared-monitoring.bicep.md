# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
sharedenv      | Yes      |
ukslocation    | Yes      |
rg_shared_monitoring | Yes      |
sharedmonitorsubscription | Yes      |

### sharedenv

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### ukslocation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### rg_shared_monitoring

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### sharedmonitorsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



## Outputs

Name | Type | Description
---- | ---- | -----------
lawop | string | ResourceID for LAW operations

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Shared-Services/Shared-Monitoring/shared-monitoring.json"
    },
    "parameters": {
        "sharedenv": {
            "value": ""
        },
        "ukslocation": {
            "value": ""
        },
        "rg_shared_monitoring": {
            "value": ""
        },
        "sharedmonitorsubscription": {
            "value": ""
        }
    }
}
```
