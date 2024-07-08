az config set extension.use_dynamic_install=yes_without_prompt

          $listspringapp = Get-AzSpringCloud -SubscriptionId 11ffd136-d5bf-4415-8943-730e458645f5 | select-object -Property name, ResourceGroupName
          foreach ($app in $listspringapp)
          {
            az spring stop --name $app.name --resource-group $app.ResourceGroupName --subscription 11ffd136-d5bf-4415-8943-730e458645f5
          }
