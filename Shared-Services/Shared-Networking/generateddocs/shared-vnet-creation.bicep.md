# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
tstenv         | No       |
envshared      | No       |
rg_shared_monitoring | No       |
ukslocation    | No       |
sharedmonitorsubscription | No       |
rg_virtual_network | No       |
sharedgateway  | No       |
vnetaddressPrefixes | No       |

### tstenv

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `test`

### envshared

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `shared`

### rg_shared_monitoring

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `rg-shared-monitoring`

### ukslocation

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `uksouth`

### sharedmonitorsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `3592b1b4-dca4-42c2-95dc-bf0902211479`

### rg_virtual_network

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `rg-virtual-networking`

### sharedgateway

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `e22eb6a5-6f38-4574-9b84-1c1dbe1c8b97`

### vnetaddressPrefixes

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `172.16.8.0/22`

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Shared-Services/Shared-Networking/shared-vnet-creation.json"
    },
    "parameters": {
        "tstenv": {
            "value": "test"
        },
        "envshared": {
            "value": "shared"
        },
        "rg_shared_monitoring": {
            "value": "rg-shared-monitoring"
        },
        "ukslocation": {
            "value": "uksouth"
        },
        "sharedmonitorsubscription": {
            "value": "3592b1b4-dca4-42c2-95dc-bf0902211479"
        },
        "rg_virtual_network": {
            "value": "rg-virtual-networking"
        },
        "sharedgateway": {
            "value": "e22eb6a5-6f38-4574-9b84-1c1dbe1c8b97"
        },
        "vnetaddressPrefixes": {
            "value": [
                "172.16.8.0/22"
            ]
        }
    }
}
```
