# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
testsub        | No       |
testsubid      | No       |
uatsubid       | No       |
uatsub         | No       |
trnsubid       | No       |
trnsub         | No       |
prodsubid      | No       |
prodsub        | No       |
managedsub     | No       |
gatewaysub     | No       |
rg_shared_monitoring | No       |
rg_springapp   | No       |

### testsub

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `f00e932c-2dc9-4eed-83ab-28bee4d9dbb3`

### testsubid

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `/subscriptions/f00e932c-2dc9-4eed-83ab-28bee4d9dbb3`

### uatsubid

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `/subscriptions/8e9001ef-d089-4768-b516-ae4be3e68dde`

### uatsub

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `8e9001ef-d089-4768-b516-ae4be3e68dde`

### trnsubid

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `/subscriptions/28949f95-bda6-4716-a7f7-3b13b40d1301e`

### trnsub

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `28949f95-bda6-4716-a7f7-3b13b40d1301`

### prodsubid

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `/subscriptions/95ca7646-ed92-470e-9dfb-23f25093d507`

### prodsub

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `95ca7646-ed92-470e-9dfb-23f25093d507`

### managedsub

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `3592b1b4-dca4-42c2-95dc-bf0902211479`

### gatewaysub

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `e22eb6a5-6f38-4574-9b84-1c1dbe1c8b97`

### rg_shared_monitoring

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `rg-shared-monitoring`

### rg_springapp

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)



- Default value: `rg-springapps`

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Shared-Services/Shared-Monitoring/shared-activitylog.json"
    },
    "parameters": {
        "testsub": {
            "value": "f00e932c-2dc9-4eed-83ab-28bee4d9dbb3"
        },
        "testsubid": {
            "value": "/subscriptions/f00e932c-2dc9-4eed-83ab-28bee4d9dbb3"
        },
        "uatsubid": {
            "value": "/subscriptions/8e9001ef-d089-4768-b516-ae4be3e68dde"
        },
        "uatsub": {
            "value": "8e9001ef-d089-4768-b516-ae4be3e68dde"
        },
        "trnsubid": {
            "value": "/subscriptions/28949f95-bda6-4716-a7f7-3b13b40d1301e"
        },
        "trnsub": {
            "value": "28949f95-bda6-4716-a7f7-3b13b40d1301"
        },
        "prodsubid": {
            "value": "/subscriptions/95ca7646-ed92-470e-9dfb-23f25093d507"
        },
        "prodsub": {
            "value": "95ca7646-ed92-470e-9dfb-23f25093d507"
        },
        "managedsub": {
            "value": "3592b1b4-dca4-42c2-95dc-bf0902211479"
        },
        "gatewaysub": {
            "value": "e22eb6a5-6f38-4574-9b84-1c1dbe1c8b97"
        },
        "rg_shared_monitoring": {
            "value": "rg-shared-monitoring"
        },
        "rg_springapp": {
            "value": "rg-springapps"
        }
    }
}
```
