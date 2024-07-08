# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
rg_virtualnetwork | Yes      | The resource group for the Virtual Network.
rg_springapp   | Yes      | The resource group for the Spring application.
rg_springapp_runtime | Yes      | The resource group for the Spring app runtime.
rg_springapp_apps | Yes      | The resource group for the Spring applications.
rg_privateendpoint | Yes      | The resource group for the private endpoint.
rg_staticwebapps | Yes      | The resource group for the static web application.
rg_sqlserver   | Yes      | The resource group for the sql server.
rg_documentstorage | Yes      | The resource group for the document storage.
rg_automation  | Yes      | The resource group for the automation.
rg_rediscache  | Yes      | The resource group for the redis cache.
rg_directus    | Yes      | The resource group for the directus.
rg_directusstorage | Yes      | The resource group for the directus storage.
rg_adb2c       | Yes      | The resource group for the Azure Active Directory B2C.
ukslocation    | Yes      | The resource group for the UK south location.
rg_malwarescanning | Yes      | The resource group for the malware scanning.
rg_datafactory | Yes      | The resource group for the Data Factory.
rg_dashboards  | Yes      | The resource group for the Dashboards
rgresourceExists | Yes      | checks if the resource group already exists

### rg_virtualnetwork

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the Virtual Network.

### rg_springapp

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the Spring application.

### rg_springapp_runtime

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the Spring app runtime.

### rg_springapp_apps

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the Spring applications.

### rg_privateendpoint

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the private endpoint.

### rg_staticwebapps

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the static web application.

### rg_sqlserver

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the sql server.

### rg_documentstorage

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the document storage.

### rg_automation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the automation.

### rg_rediscache

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the redis cache.

### rg_directus

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the directus.

### rg_directusstorage

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the directus storage.

### rg_adb2c

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the Azure Active Directory B2C.

### ukslocation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the UK south location.

### rg_malwarescanning

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the malware scanning.

### rg_datafactory

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the Data Factory.

### rg_dashboards

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the Dashboards

### rgresourceExists

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

checks if the resource group already exists

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Polaris/Polaris-RG/polaris-rg-create.json"
    },
    "parameters": {
        "rg_virtualnetwork": {
            "value": ""
        },
        "rg_springapp": {
            "value": ""
        },
        "rg_springapp_runtime": {
            "value": ""
        },
        "rg_springapp_apps": {
            "value": ""
        },
        "rg_privateendpoint": {
            "value": ""
        },
        "rg_staticwebapps": {
            "value": ""
        },
        "rg_sqlserver": {
            "value": ""
        },
        "rg_documentstorage": {
            "value": ""
        },
        "rg_automation": {
            "value": ""
        },
        "rg_rediscache": {
            "value": ""
        },
        "rg_directus": {
            "value": ""
        },
        "rg_directusstorage": {
            "value": ""
        },
        "rg_adb2c": {
            "value": ""
        },
        "ukslocation": {
            "value": ""
        },
        "rg_malwarescanning": {
            "value": ""
        },
        "rg_datafactory": {
            "value": ""
        },
        "rg_dashboards": {
            "value": ""
        },
        "rgresourceExists": {
            "value": null
        }
    }
}
```
