# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
tstenv         | Yes      |
envshared      | No       |
rg_shared_monitoring | Yes      |
ukslocation    | Yes      |
plspringapplbnametst | Yes      |
plspringapplbnameuat | Yes      |
plspringapplbnametrn | Yes      |
plspringapplbnameprod | Yes      |
sharedmonitorsubscription | Yes      |
rg_virtual_network | Yes      |
sharedgateway  | Yes      |
tstrgvirtualnetworking | Yes      |
tstsubscription | Yes      |
uatrgvirtualnetworking | Yes      |
uatsubscription | Yes      |
trnrgvirtualnetworking | Yes      |
trnsubscription | Yes      |
prodrgvirtualnetworking | Yes      |
prodsubscription | Yes      |
waftstname     | Yes      |
wafuatname     | Yes      |
waftrnname     | Yes      |
wafprodname    | Yes      |
IPAllowListTEST | Yes      |
IPAllowListUAT | Yes      |
IPAllowListTRN | Yes      |
IPAllowListPROD | Yes      |

### tstenv

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### envshared

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `shared`

### rg_shared_monitoring

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### ukslocation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### plspringapplbnametst

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### plspringapplbnameuat

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### plspringapplbnametrn

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### plspringapplbnameprod

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### sharedmonitorsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### rg_virtual_network

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### sharedgateway

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### tstrgvirtualnetworking

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### tstsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### uatrgvirtualnetworking

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### uatsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### trnrgvirtualnetworking

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### trnsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### prodrgvirtualnetworking

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### prodsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### waftstname

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### wafuatname

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### waftrnname

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### wafprodname

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### IPAllowListTEST

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### IPAllowListUAT

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### IPAllowListTRN

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### IPAllowListPROD

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Shared-Services/Shared-Networking/shared-networking.json"
    },
    "parameters": {
        "tstenv": {
            "value": ""
        },
        "envshared": {
            "value": "shared"
        },
        "rg_shared_monitoring": {
            "value": ""
        },
        "ukslocation": {
            "value": ""
        },
        "plspringapplbnametst": {
            "value": ""
        },
        "plspringapplbnameuat": {
            "value": ""
        },
        "plspringapplbnametrn": {
            "value": ""
        },
        "plspringapplbnameprod": {
            "value": ""
        },
        "sharedmonitorsubscription": {
            "value": ""
        },
        "rg_virtual_network": {
            "value": ""
        },
        "sharedgateway": {
            "value": ""
        },
        "tstrgvirtualnetworking": {
            "value": ""
        },
        "tstsubscription": {
            "value": ""
        },
        "uatrgvirtualnetworking": {
            "value": ""
        },
        "uatsubscription": {
            "value": ""
        },
        "trnrgvirtualnetworking": {
            "value": ""
        },
        "trnsubscription": {
            "value": ""
        },
        "prodrgvirtualnetworking": {
            "value": ""
        },
        "prodsubscription": {
            "value": ""
        },
        "waftstname": {
            "value": ""
        },
        "wafuatname": {
            "value": ""
        },
        "waftrnname": {
            "value": ""
        },
        "wafprodname": {
            "value": ""
        },
        "IPAllowListTEST": {
            "value": []
        },
        "IPAllowListUAT": {
            "value": []
        },
        "IPAllowListTRN": {
            "value": []
        },
        "IPAllowListPROD": {
            "value": []
        }
    }
}
```
