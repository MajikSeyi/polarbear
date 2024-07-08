#!/bin/bash

echo
echo "Create network settings resource ns-github"

az resource create \
  --resource-group rg-github-private-runners \
  --name ns-github \
  --resource-type GitHub.Network/networkSettings \
  --properties "{\"location\": \"uksouth\", \"properties\": {\"subnetId\": \"/subscriptions/b6dedd61-95e4-477c-a8cb-1fa7e8326efd/resourceGroups/rg-virtual-networking/providers/Microsoft.Network/virtualNetworks/vnet-rsr-management-uksouth/subnets/GithubActionRunnersSubnet\", \"businessId\": \"17771\"}}" \
  --is-full-object \
  --output table \
  --query "{GitHubId:tags.GitHubId, name:name}" \
  --api-version 2024-04-02
