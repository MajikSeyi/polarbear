# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
sharedmonitorsubscription | Yes      |
rg_shared_b2c  | Yes      |
ukslocation    | Yes      |
rg_shared_monitoring | Yes      |
rg_shared_containerregistries | Yes      |

### sharedmonitorsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### rg_shared_b2c

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### ukslocation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### rg_shared_monitoring

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### rg_shared_containerregistries

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Shared-Services/Shared-Orchestration/Polaris-RG/Shared-rg-create.json"
    },
    "parameters": {
        "sharedmonitorsubscription": {
            "value": ""
        },
        "rg_shared_b2c": {
            "value": ""
        },
        "ukslocation": {
            "value": ""
        },
        "rg_shared_monitoring": {
            "value": ""
        },
        "rg_shared_containerregistries": {
            "value": ""
        }
    }
}
```
