# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
ukslocation    | Yes      | The location for resources in the UK South region.
envshared      | Yes      | The shared environment name.
rg_springapps  | No       | Resource group for Spring applications.
sharedmonitorsubscription | Yes      | The subscription for shared monitoring.
env            | Yes      | The environment name.
rg_datafactory | Yes      | The resource group for the Data Factory.
rg_shared_monitoring | Yes      | The resource group for the shared monitoring.
rg_virtual_networking | No       | The resource group for the shared monitoring.
privatednsvaultcore | Yes      | Private DNS for Azure Vault Core.
snetazuksouthxp | Yes      | Subnet resource id for azuksouth-xp
snetazuksouthgs | Yes      | Subnet resource id for azuksouth-xp
adfresourceExists | Yes      | Indicates whether to run ADF .
kvresourceExists | Yes      | Indicates whether a key vault is present.
corecount      | Yes      | Required - DataFactory CoreCount
ttltype        | Yes      | Required - DataFactory ttltype
ttlpipeline    | Yes      | Required - DataFactory ttlpipeline
pipelinenode   | Yes      | Required - DataFactory pipelinenode
externalnode   | Yes      | Required - DataFactory externalnode

### ukslocation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The location for resources in the UK South region.

### envshared

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The shared environment name.

### rg_springapps

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Resource group for Spring applications.

- Default value: `rg-springapps`

### sharedmonitorsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The subscription for shared monitoring.

### env

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The environment name.

### rg_datafactory

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the Data Factory.

### rg_shared_monitoring

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the shared monitoring.

### rg_virtual_networking

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

The resource group for the shared monitoring.

- Default value: `rg-virtual-networking`

### privatednsvaultcore

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private DNS for Azure Vault Core.

### snetazuksouthxp

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Subnet resource id for azuksouth-xp

### snetazuksouthgs

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Subnet resource id for azuksouth-xp

### adfresourceExists

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Indicates whether to run ADF .

### kvresourceExists

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Indicates whether a key vault is present.

### corecount

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required - DataFactory CoreCount

### ttltype

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required - DataFactory ttltype

### ttlpipeline

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required - DataFactory ttlpipeline

### pipelinenode

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required - DataFactory pipelinenode

### externalnode

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required - DataFactory externalnode

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Polaris/Polaris-Data-Factory/polaris-data-factory.json"
    },
    "parameters": {
        "ukslocation": {
            "value": ""
        },
        "envshared": {
            "value": ""
        },
        "rg_springapps": {
            "value": "rg-springapps"
        },
        "sharedmonitorsubscription": {
            "value": ""
        },
        "env": {
            "value": ""
        },
        "rg_datafactory": {
            "value": ""
        },
        "rg_shared_monitoring": {
            "value": ""
        },
        "rg_virtual_networking": {
            "value": "rg-virtual-networking"
        },
        "privatednsvaultcore": {
            "value": ""
        },
        "snetazuksouthxp": {
            "value": ""
        },
        "snetazuksouthgs": {
            "value": ""
        },
        "adfresourceExists": {
            "value": null
        },
        "kvresourceExists": {
            "value": null
        },
        "corecount": {
            "value": 0
        },
        "ttltype": {
            "value": 0
        },
        "ttlpipeline": {
            "value": 0
        },
        "pipelinenode": {
            "value": 0
        },
        "externalnode": {
            "value": 0
        }
    }
}
```
