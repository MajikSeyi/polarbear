# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
location       | Yes      |
env            | Yes      |

### location

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### env

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Shared-Services/Shared-DB-Storage/shared-db-storage.json"
    },
    "parameters": {
        "location": {
            "value": ""
        },
        "env": {
            "value": ""
        }
    }
}
```
