# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
ukslocation    | Yes      |
env            | Yes      |
rg_springapp   | Yes      | Optional. Resource group for Spring applications.
appconfigsku   | Yes      | Optional. Standard Application configuration
rg_sqlserver   | Yes      | Optional. Resource group for the SQL server.
rg_documentstorage | Yes      | Resource group for Document Storage
rg_shared_monitoring | Yes      | Resource group for Shared Monitoring
rgautomation   | Yes      | Resource group for Automation
rg_directusstorage | Yes      | Resource group for Directus storage
rg_rediscache  | Yes      | Resource group for the Azure cache for Redis
rg_malwarescanning | Yes      | Resource group for Malware Scanning
weekylong      | Yes      | Weekly retention period for databasebackup.NOTE- PT0S format
monthlylong    | Yes      | Monthly retention period for databasebackup.NOTE- PT0S format
yearlyRetention | Yes      | Yearly retention period for databasebackup.NOTE- PT0S format
requestedBackupStorageRedundancy | Yes      | Backup Storage Redundancy configuration
administratorLogin | Yes      | The administrator username for the server. Required if no administrators object for AAD authentication is provided.
administratorLoginPassword | Yes      | The administrator login password. Required if no administrators object for AAD authentication is provided.
mainexpire     | Yes      | Expiration date time for maintenance window
mainrecur      | Yes      | How many times for the maintenance to recur
mainstart      | Yes      | When the start date time is for the maintenance window
maintimezone   | Yes      | To set the local timezone where the maintance will happen.
mainduration   | Yes      | How long the duration will be
adsqllogin     | Yes      | Login username for the sqlserver
sidsql         | Yes      | What the Sql Service ID is - 85d74a37-0cdc-43fd-b278-eef21a4037da
tentantid      | Yes      | The unique Tenant ID - 3d97076e-80d1-41ff-9ebb-3c9d9ee234ad
sharedmonitorsubscription | Yes      | The shared monitoring subscription
envshared      | Yes      | The defined shared environment
untrustedstgpresent | Yes      | Check if the STG present is untrusted, if true dont execute, if false continue and execute.
automationstartTime | Yes      | automation schedule start time
subscriptionid | Yes      |
skuCapacity    | Yes      | Capacity of the particular SKU for the SQLDB
skuName        | Yes      | The name of the SKU for the SQLDB
zoneRedundant  | Yes      |

### ukslocation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### env

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### rg_springapp

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. Resource group for Spring applications.

### appconfigsku

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. Standard Application configuration

### rg_sqlserver

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. Resource group for the SQL server.

### rg_documentstorage

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Resource group for Document Storage

### rg_shared_monitoring

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Resource group for Shared Monitoring

### rgautomation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Resource group for Automation

### rg_directusstorage

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Resource group for Directus storage

### rg_rediscache

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Resource group for the Azure cache for Redis

### rg_malwarescanning

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Resource group for Malware Scanning

### weekylong

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Weekly retention period for databasebackup.NOTE- PT0S format

### monthlylong

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Monthly retention period for databasebackup.NOTE- PT0S format

### yearlyRetention

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Yearly retention period for databasebackup.NOTE- PT0S format

### requestedBackupStorageRedundancy

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Backup Storage Redundancy configuration

### administratorLogin

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The administrator username for the server. Required if no administrators object for AAD authentication is provided.

### administratorLoginPassword

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The administrator login password. Required if no administrators object for AAD authentication is provided.

### mainexpire

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Expiration date time for maintenance window

### mainrecur

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

How many times for the maintenance to recur

### mainstart

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

When the start date time is for the maintenance window

### maintimezone

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

To set the local timezone where the maintance will happen.

### mainduration

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

How long the duration will be

### adsqllogin

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Login username for the sqlserver

### sidsql

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

What the Sql Service ID is - 85d74a37-0cdc-43fd-b278-eef21a4037da

### tentantid

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The unique Tenant ID - 3d97076e-80d1-41ff-9ebb-3c9d9ee234ad

### sharedmonitorsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The shared monitoring subscription

### envshared

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The defined shared environment

### untrustedstgpresent

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Check if the STG present is untrusted, if true dont execute, if false continue and execute.

### automationstartTime

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

automation schedule start time

### subscriptionid

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### skuCapacity

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Capacity of the particular SKU for the SQLDB

### skuName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The name of the SKU for the SQLDB

### zoneRedundant

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Polaris/Polaris-Foundation/polaris-foundation.json"
    },
    "parameters": {
        "ukslocation": {
            "value": ""
        },
        "env": {
            "value": ""
        },
        "rg_springapp": {
            "value": ""
        },
        "appconfigsku": {
            "value": ""
        },
        "rg_sqlserver": {
            "value": ""
        },
        "rg_documentstorage": {
            "value": ""
        },
        "rg_shared_monitoring": {
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
        "weekylong": {
            "value": ""
        },
        "monthlylong": {
            "value": ""
        },
        "yearlyRetention": {
            "value": ""
        },
        "requestedBackupStorageRedundancy": {
            "value": ""
        },
        "administratorLogin": {
            "value": ""
        },
        "administratorLoginPassword": {
            "reference": {
                "keyVault": {
                    "id": ""
                },
                "secretName": ""
            }
        },
        "mainexpire": {
            "value": ""
        },
        "mainrecur": {
            "value": ""
        },
        "mainstart": {
            "value": ""
        },
        "maintimezone": {
            "value": ""
        },
        "mainduration": {
            "value": ""
        },
        "adsqllogin": {
            "value": ""
        },
        "sidsql": {
            "value": ""
        },
        "tentantid": {
            "value": ""
        },
        "sharedmonitorsubscription": {
            "value": ""
        },
        "envshared": {
            "value": ""
        },
        "untrustedstgpresent": {
            "value": null
        },
        "automationstartTime": {
            "value": ""
        },
        "subscriptionid": {
            "value": ""
        },
        "skuCapacity": {
            "value": 0
        },
        "skuName": {
            "value": ""
        },
        "zoneRedundant": {
            "value": null
        }
    }
}
```
