# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
rg_sqlserver   | Yes      | Specifies the value of the secret that you want to create.
rg_shared_monitoring | Yes      |
sqldatabase    | Yes      |
ukslocation    | Yes      |
env            | Yes      |
envshared      | Yes      |
sharedmonitorsubscription | Yes      |

### rg_sqlserver

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Specifies the value of the secret that you want to create.

### rg_shared_monitoring

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### sqldatabase

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### ukslocation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### env

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### envshared

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### sharedmonitorsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Polaris/Polaris-Foundation/polaris-foundation-monitoring.json"
    },
    "parameters": {
        "rg_sqlserver": {
            "reference": {
                "keyVault": {
                    "id": ""
                },
                "secretName": ""
            }
        },
        "rg_shared_monitoring": {
            "value": ""
        },
        "sqldatabase": {
            "value": ""
        },
        "ukslocation": {
            "value": ""
        },
        "env": {
            "value": ""
        },
        "envshared": {
            "value": ""
        },
        "sharedmonitorsubscription": {
            "value": ""
        }
    }
}
```
