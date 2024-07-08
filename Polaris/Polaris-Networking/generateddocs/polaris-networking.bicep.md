# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
ukslocation    | Yes      | The location for resources in the UK South region.
env            | Yes      | The environment name.
envshared      | Yes      | The shared environment name.
vnetaddressPrefixes | Yes      | Array of address prefixes for the virtual network.
IPRuntimeSubnet | Yes      | The IP address for the runtime subnet.
IPApplicationsSubnet | Yes      | The IP address for the applications subnet.
IPPrivateLinkSubnet | Yes      | The IP address for the Private Link subnet.
IPPrivateEndpointsSubnet | Yes      | The IP address for the Private Endpoints subnet.
IPAppServicesSubnet | Yes      | The IP address for the App Services subnet.
nextHopIp      | Yes      | The next hop IP address.
rgvirtualnetworking | Yes      | The resource group for virtual networking.
rgprivateendpoints | Yes      | The resource group for private endpoints.
rg_springapp   | Yes      | The resource group for Spring applications.
rg_sqlserver   | Yes      | The resource group for SQL Server.
rg_shared_monitoring | Yes      | The resource group for shared monitoring.
rg_shared_containerregistries | Yes      | The resource group for shared container registries.
rg_documentstorage | Yes      | The resource group for document storage.
rgautomation   | Yes      | The resource group for automation.
rg_directusstorage | Yes      | The resource group for Directus storage.
rg_rediscache  | Yes      | The resource group for Redis Cache.
rg_malwarescanning | Yes      | The resource group for malware scanning.
kvgroupIds     | Yes      | Array of group IDs for Key Vault.
azconfiggroupIds | Yes      | Array of group IDs for Configuration Stores.
sqlgroupIds    | Yes      | Array of group IDs for SQL Server.
blobgroupIds   | Yes      | Array of group IDs for Blob storage.
filegroupIds   | Yes      | Array of group IDs for File storage.
queuegroupIds  | Yes      | Array of group IDs for Queue storage.
automategroupIds | Yes      | Array of group IDs for Webhooks.
containerreggroupIds | Yes      | Array of group IDs for Container Registries.
rediscachegroupIds | Yes      | Array of group IDs for Redis Cache.
vnetappname    | Yes      | The name for the virtual network.
privatednsappconfig | Yes      | Private DNS for Azure App Configuration.
privatednsmicro | Yes      | Private DNS for Azure Microservices.
privatednsvaultcore | Yes      | Private DNS for Azure Vault Core.
privatednsdatabase | Yes      | Private DNS for Azure Database.
privatednsblobcore | Yes      | Private DNS for Azure Blob Core.
privatednsfilecore | Yes      | Private DNS for Azure File Core.
privatednsqueuecore | Yes      | Private DNS for Azure Queue Core.
privateautomation | Yes      | Private DNS for Azure Automation.
privatecontainerregistry | Yes      | Private DNS for Azure Container Registry.
privaterediscache | Yes      | Private DNS for Azure Redis Cache.
privateazurewebsites | Yes      | Private DNS for Azure Websites.
sharedmonitorsubscription | Yes      | The subscription for shared monitoring.

### ukslocation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The location for resources in the UK South region.

### env

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The environment name.

### envshared

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The shared environment name.

### vnetaddressPrefixes

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Array of address prefixes for the virtual network.

### IPRuntimeSubnet

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The IP address for the runtime subnet.

### IPApplicationsSubnet

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The IP address for the applications subnet.

### IPPrivateLinkSubnet

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The IP address for the Private Link subnet.

### IPPrivateEndpointsSubnet

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The IP address for the Private Endpoints subnet.

### IPAppServicesSubnet

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The IP address for the App Services subnet.

### nextHopIp

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The next hop IP address.

### rgvirtualnetworking

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for virtual networking.

### rgprivateendpoints

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for private endpoints.

### rg_springapp

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for Spring applications.

### rg_sqlserver

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for SQL Server.

### rg_shared_monitoring

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for shared monitoring.

### rg_shared_containerregistries

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for shared container registries.

### rg_documentstorage

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for document storage.

### rgautomation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for automation.

### rg_directusstorage

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for Directus storage.

### rg_rediscache

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for Redis Cache.

### rg_malwarescanning

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for malware scanning.

### kvgroupIds

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Array of group IDs for Key Vault.

### azconfiggroupIds

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Array of group IDs for Configuration Stores.

### sqlgroupIds

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Array of group IDs for SQL Server.

### blobgroupIds

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Array of group IDs for Blob storage.

### filegroupIds

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Array of group IDs for File storage.

### queuegroupIds

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Array of group IDs for Queue storage.

### automategroupIds

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Array of group IDs for Webhooks.

### containerreggroupIds

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Array of group IDs for Container Registries.

### rediscachegroupIds

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Array of group IDs for Redis Cache.

### vnetappname

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The name for the virtual network.

### privatednsappconfig

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private DNS for Azure App Configuration.

### privatednsmicro

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private DNS for Azure Microservices.

### privatednsvaultcore

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private DNS for Azure Vault Core.

### privatednsdatabase

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private DNS for Azure Database.

### privatednsblobcore

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private DNS for Azure Blob Core.

### privatednsfilecore

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private DNS for Azure File Core.

### privatednsqueuecore

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private DNS for Azure Queue Core.

### privateautomation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private DNS for Azure Automation.

### privatecontainerregistry

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private DNS for Azure Container Registry.

### privaterediscache

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private DNS for Azure Redis Cache.

### privateazurewebsites

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Private DNS for Azure Websites.

### sharedmonitorsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The subscription for shared monitoring.

## Outputs

Name | Type | Description
---- | ---- | -----------
kvnameresourceid | string |
privatesub | string |
appconfigid | string |

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Polaris/Polaris-Networking/polaris-networking.json"
    },
    "parameters": {
        "ukslocation": {
            "value": ""
        },
        "env": {
            "value": ""
        },
        "envshared": {
            "value": ""
        },
        "vnetaddressPrefixes": {
            "value": []
        },
        "IPRuntimeSubnet": {
            "value": ""
        },
        "IPApplicationsSubnet": {
            "value": ""
        },
        "IPPrivateLinkSubnet": {
            "value": ""
        },
        "IPPrivateEndpointsSubnet": {
            "value": ""
        },
        "IPAppServicesSubnet": {
            "value": ""
        },
        "nextHopIp": {
            "value": ""
        },
        "rgvirtualnetworking": {
            "value": ""
        },
        "rgprivateendpoints": {
            "value": ""
        },
        "rg_springapp": {
            "value": ""
        },
        "rg_sqlserver": {
            "value": ""
        },
        "rg_shared_monitoring": {
            "value": ""
        },
        "rg_shared_containerregistries": {
            "value": ""
        },
        "rg_documentstorage": {
            "value": ""
        },
        "rgautomation": {
            "value": ""
        },
        "rg_directusstorage": {
            "value": ""
        },
        "rg_rediscache": {
            "value": ""
        },
        "rg_malwarescanning": {
            "value": ""
        },
        "kvgroupIds": {
            "value": []
        },
        "azconfiggroupIds": {
            "value": []
        },
        "sqlgroupIds": {
            "value": []
        },
        "blobgroupIds": {
            "value": []
        },
        "filegroupIds": {
            "value": []
        },
        "queuegroupIds": {
            "value": []
        },
        "automategroupIds": {
            "value": []
        },
        "containerreggroupIds": {
            "value": []
        },
        "rediscachegroupIds": {
            "value": []
        },
        "vnetappname": {
            "value": ""
        },
        "privatednsappconfig": {
            "value": ""
        },
        "privatednsmicro": {
            "value": ""
        },
        "privatednsvaultcore": {
            "value": ""
        },
        "privatednsdatabase": {
            "value": ""
        },
        "privatednsblobcore": {
            "value": ""
        },
        "privatednsfilecore": {
            "value": ""
        },
        "privatednsqueuecore": {
            "value": ""
        },
        "privateautomation": {
            "value": ""
        },
        "privatecontainerregistry": {
            "value": ""
        },
        "privaterediscache": {
            "value": ""
        },
        "privateazurewebsites": {
            "value": ""
        },
        "sharedmonitorsubscription": {
            "value": ""
        }
    }
}
```
