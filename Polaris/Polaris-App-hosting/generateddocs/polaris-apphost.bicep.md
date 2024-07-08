# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
privatednsmicro | Yes      | This is a private dns zone which will hold a custom domain name string
rg_springapp   | Yes      | Resource group for Spring applications.
rgvirtualnetworking | Yes      | The resource group for the virtual networking
RuntimeNetworkResourceGroup | Yes      | The resource group for the runtime networking resources
lbcheckname    | No       | The name for the load balancer check
appNetworkResourceGroup | Yes      | The resource group for the application networking resources
rgstaticwebapp | Yes      | The resource group for the static web app
rg_directus    | Yes      | The resource group for Directus.
rg_directusstorage | Yes      | The resource group for Directus storage.
rg_malwarescanning | Yes      | The resource group for malware scanning
rg_shared_monitoring | Yes      | The resource group for shared monitoring
rg_documentstorage | Yes      | The resource group for document storage
swalocation    | Yes      | The location for the static web app
swarepourl     | Yes      | The URL for the static web app repo.
swarepourlb2c  | Yes      | The URL for the static web app repo used with B2C.
swabranch      | Yes      | The branch for the static web app.
ukslocation    | Yes      | The location for resources in the UK South region.
swaname        | No       | The name for the static web app.
swadb2c        | No       | The name for the static web app used with B2C
env            | Yes      | The environment name.
acrenv         | Yes      | Directus environment name.NOTE - Prod must be called Production
envshared      | Yes      | The shared environment name.
springCloudInstanceName | Yes      | The name for the Spring app.
springCloudServiceCidrs | No       | The CIDR blocks for the Spring Cloud service.
calendarservice | Yes      | The name for the calendar service.
sharedmonitorsubscription | Yes      | The subscription for shared monitoring.
appconfig_endpoint | Yes      | The endpoint for the application configuration.
coursename     | Yes      | The name for the course.
participantename | Yes      | The name for the participant.
communicationname | Yes      | The name for the communication service.
usernameservice | Yes      | The name for the username service.
directusmanagement | Yes      | The Directus management settings.
documentsservice | Yes      | The name for the documents service.
recruitmentservice | Yes      | The name for the recruitment service.
resourcespringappExists | Yes      | Indicates whether resources for the Spring app exist.
untrustedstgpresent | Yes      | Indicates whether an untrusted storage account is present.
appconfigpath  | Yes      | The path for the application configuration.
rgautomation   | No       | The resource group for automation resources.
availabilitytestparams | Yes      | the array values of availability test names and request url
frequency      | Yes      | Interval in seconds between test runs for the availability test.
timeout        | Yes      | Seconds until the availability test will timeout and fail.
alertCriteriaType | Yes      | Optional. Maps to the 'odata.type' field. Specifies the type of the alert criteria.
autoMitigate   | Yes      | Optional. The flag that indicates whether the alert should be auto resolved or not.
severity       | Yes      | Optional. The severity of the alert.
evaluationFrequency | Yes      | Optional. how often the metric alert is evaluated represented in ISO 8601 duration format.
windowSize     | Yes      | Optional. the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold.
aspSkuName     | Yes      | Name of the App Service Plan SKU.
aspSkuTier     | Yes      | Service tier of the App Service Plan SKU.
aspSkuSize     | Yes      | Size specifier of the App Service Plan SKU.
aspSkuFamily   | Yes      | Family code of the App Service Plan SKU.
aspSkuCapacity | Yes      | Current number of instances assigned to the App Service Plan SKU.
zoneRedundant  | Yes      | Spring app zone redundancy

### privatednsmicro

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

This is a private dns zone which will hold a custom domain name string

### rg_springapp

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Resource group for Spring applications.

### rgvirtualnetworking

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the virtual networking

### RuntimeNetworkResourceGroup

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the runtime networking resources

### lbcheckname

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

The name for the load balancer check

- Default value: `kubernetes-internal`

### appNetworkResourceGroup

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the application networking resources

### rgstaticwebapp

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for the static web app

### rg_directus

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for Directus.

### rg_directusstorage

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for Directus storage.

### rg_malwarescanning

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for malware scanning

### rg_shared_monitoring

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for shared monitoring

### rg_documentstorage

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The resource group for document storage

### swalocation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The location for the static web app

### swarepourl

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The URL for the static web app repo.

### swarepourlb2c

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The URL for the static web app repo used with B2C.

### swabranch

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The branch for the static web app.

### ukslocation

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The location for resources in the UK South region.

### swaname

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

The name for the static web app.

- Default value: `swa-frontend-polaris-`

### swadb2c

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

The name for the static web app used with B2C

- Default value: `swa-adb2c-custom-ui-polaris-`

### env

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The environment name.

### acrenv

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Directus environment name.NOTE - Prod must be called Production

### envshared

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The shared environment name.

### springCloudInstanceName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The name for the Spring app.

### springCloudServiceCidrs

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

The CIDR blocks for the Spring Cloud service.

- Default value: `10.0.0.0/16,10.2.0.0/16,10.3.0.1/16`

### calendarservice

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The name for the calendar service.

### sharedmonitorsubscription

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The subscription for shared monitoring.

### appconfig_endpoint

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The endpoint for the application configuration.

### coursename

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The name for the course.

### participantename

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The name for the participant.

### communicationname

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The name for the communication service.

### usernameservice

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The name for the username service.

### directusmanagement

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The Directus management settings.

### documentsservice

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The name for the documents service.

### recruitmentservice

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The name for the recruitment service.

### resourcespringappExists

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Indicates whether resources for the Spring app exist.

### untrustedstgpresent

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Indicates whether an untrusted storage account is present.

### appconfigpath

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

The path for the application configuration.

### rgautomation

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

The resource group for automation resources.

- Default value: `rg-automation`

### availabilitytestparams

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

the array values of availability test names and request url

### frequency

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Interval in seconds between test runs for the availability test.

### timeout

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Seconds until the availability test will timeout and fail.

### alertCriteriaType

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. Maps to the 'odata.type' field. Specifies the type of the alert criteria.

### autoMitigate

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. The flag that indicates whether the alert should be auto resolved or not.

### severity

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. The severity of the alert.

### evaluationFrequency

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. how often the metric alert is evaluated represented in ISO 8601 duration format.

### windowSize

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Optional. the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold.

### aspSkuName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Name of the App Service Plan SKU.

### aspSkuTier

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Service tier of the App Service Plan SKU.

### aspSkuSize

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Size specifier of the App Service Plan SKU.

### aspSkuFamily

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Family code of the App Service Plan SKU.

### aspSkuCapacity

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Current number of instances assigned to the App Service Plan SKU.

### zoneRedundant

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Spring app zone redundancy

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Polaris/Polaris-App-hosting/polaris-apphost.json"
    },
    "parameters": {
        "privatednsmicro": {
            "value": ""
        },
        "rg_springapp": {
            "value": ""
        },
        "rgvirtualnetworking": {
            "value": ""
        },
        "RuntimeNetworkResourceGroup": {
            "value": ""
        },
        "lbcheckname": {
            "value": "kubernetes-internal"
        },
        "appNetworkResourceGroup": {
            "value": ""
        },
        "rgstaticwebapp": {
            "value": ""
        },
        "rg_directus": {
            "value": ""
        },
        "rg_directusstorage": {
            "value": ""
        },
        "rg_malwarescanning": {
            "value": ""
        },
        "rg_shared_monitoring": {
            "value": ""
        },
        "rg_documentstorage": {
            "value": ""
        },
        "swalocation": {
            "value": ""
        },
        "swarepourl": {
            "value": ""
        },
        "swarepourlb2c": {
            "value": ""
        },
        "swabranch": {
            "value": ""
        },
        "ukslocation": {
            "value": ""
        },
        "swaname": {
            "value": "swa-frontend-polaris-"
        },
        "swadb2c": {
            "value": "swa-adb2c-custom-ui-polaris-"
        },
        "env": {
            "value": ""
        },
        "acrenv": {
            "value": ""
        },
        "envshared": {
            "value": ""
        },
        "springCloudInstanceName": {
            "value": ""
        },
        "springCloudServiceCidrs": {
            "value": "10.0.0.0/16,10.2.0.0/16,10.3.0.1/16"
        },
        "calendarservice": {
            "value": ""
        },
        "sharedmonitorsubscription": {
            "value": ""
        },
        "appconfig_endpoint": {
            "value": ""
        },
        "coursename": {
            "value": ""
        },
        "participantename": {
            "value": ""
        },
        "communicationname": {
            "value": ""
        },
        "usernameservice": {
            "value": ""
        },
        "directusmanagement": {
            "value": ""
        },
        "documentsservice": {
            "value": ""
        },
        "recruitmentservice": {
            "value": ""
        },
        "resourcespringappExists": {
            "value": null
        },
        "untrustedstgpresent": {
            "value": null
        },
        "appconfigpath": {
            "value": ""
        },
        "rgautomation": {
            "value": "rg-automation"
        },
        "availabilitytestparams": {
            "value": []
        },
        "frequency": {
            "value": 0
        },
        "timeout": {
            "value": 0
        },
        "alertCriteriaType": {
            "value": ""
        },
        "autoMitigate": {
            "value": null
        },
        "severity": {
            "value": 0
        },
        "evaluationFrequency": {
            "value": ""
        },
        "windowSize": {
            "value": ""
        },
        "aspSkuName": {
            "value": ""
        },
        "aspSkuTier": {
            "value": ""
        },
        "aspSkuSize": {
            "value": ""
        },
        "aspSkuFamily": {
            "value": ""
        },
        "aspSkuCapacity": {
            "value": 0
        },
        "zoneRedundant": {
            "value": null
        }
    }
}
```
