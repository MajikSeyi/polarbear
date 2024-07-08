// WAF Param //



// Param Test
param waf_tst_name string
param IPAllowListTEST array


// Param UAT
param waf_uat_name string
param IPAllowListUAT array

// Param Training

param waf_trn_name string
param IPAllowListTRN array

// Param Prod
param waf_prod_name string
param IPAllowListPROD array

////////////////////////
// IP List Breakdown //
//////////////////////

/////////////
/// Test /// 
///////////


///// Reed On-premises IPs
// '195.138.205.241'
// '195.138.205.201'
// '195.138.205.237'
// '195.138.205.238'
// '195.138.205.239'
// '195.138.205.240'


///// Cloud Qualys Scan IPs
// "151.104.32.115",
// "151.104.32.131",
// "151.104.32.9",
// "151.104.33.133",
// "151.104.33.135",
// "151.104.33.225",
// "151.104.34.102",
// "151.104.34.22",
// "151.104.34.237",
// "151.104.34.255",
// "151.104.34.6",
// "151.104.35.184",
// "151.104.35.212",
// "151.104.35.215",
// "151.104.35.241",
// "151.104.35.70" 

///// Azure Application Insights Availability Test IPs

// "13.73.253.112/29",
// "20.49.111.32/29",
// "51.104.30.160/29",
// "20.40.104.96/28",
// "51.137.164.200/29",
// "51.105.9.128/28"


/////////////
/// UAT /// 
///////////


///// Reed On-premises IPs
// '195.138.205.241'
// '195.138.205.201'
// '195.138.205.237'
// '195.138.205.238'
// '195.138.205.239'
// '195.138.205.240'


///// Cloud Qualys Scan IPs
// "151.104.32.115",
// "151.104.32.131",
// "151.104.32.9",
// "151.104.33.133",
// "151.104.33.135",
// "151.104.33.225",
// "151.104.34.102",
// "151.104.34.22",
// "151.104.34.237",
// "151.104.34.255",
// "151.104.34.6",
// "151.104.35.184",
// "151.104.35.212",
// "151.104.35.215",
// "151.104.35.241",
// "151.104.35.70" 

///// Azure Application Insights Availability Test IPs

// "13.73.253.112/29",
// "20.49.111.32/29",
// "51.104.30.160/29",
// "20.40.104.96/28",
// "51.137.164.200/29",
// "51.105.9.128/28"

///// Azure Pen Test Partner

// "212.38.169.64/27",
// "78.129.217.224/27",
// "91.238.238.0/25"

///// Rip Supply Chain

// "188.39.198.146",
// "51.141.238.109",
// "193.201.64.14"








////////////
/// TST ///
//////////

resource wafpolaristest 'Microsoft.Network/frontdoorwebapplicationfirewallpolicies@2022-05-01' = {
  name: waf_tst_name
  location: 'Global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    policySettings: {
      enabledState: 'Enabled'
      mode: 'Prevention'
      customBlockResponseStatusCode: 403
      customBlockResponseBody: 'WW91IGFyZSBub3QgYXV0aG9yaXNlZCB0byBhY2Nlc3MgdGhpcyByZXNvdXJjZSwgcGxlYXNlIGNvbnRhY3QgSVQgdG8gcmVxdWVzdCBhY2Nlc3Mu'

      requestBodyCheck: 'Enabled'
    }
    customRules: {
      rules: [
        {
          name: 'IPAllowList'
          enabledState: 'Enabled'
          priority: 100
          ruleType: 'MatchRule'
          rateLimitDurationInMinutes: 1
          rateLimitThreshold: 100
          matchConditions: [
            {
              matchVariable: 'SocketAddr'
              operator: 'IPMatch'
              negateCondition: true
              matchValue: IPAllowListTEST
              transforms: []
            }
          ]
          action: 'Block'
        }
      ]
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'Microsoft_DefaultRuleSet'
          ruleSetVersion: '2.1'
          ruleSetAction: 'Block'
          ruleGroupOverrides: [
            {
              ruleGroupName: 'MS-ThreatIntel-CVEs'
              rules: [
                {
                  ruleId: '99001016'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
                {
                  ruleId: '99001015'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
                {
                  ruleId: '99001014'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'MS-ThreatIntel-WebShells'
              rules: [
                {
                  ruleId: '99005006'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'General'
              rules: [
                {
                  ruleId: '200003'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '200002'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'MS-ThreatIntel-SQLI'
              rules: [
                {
                  ruleId: '99031004'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '99031002'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '99031001'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'PROTOCOL-ATTACK'
              rules: [
                {
                  ruleId: '921200'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'PROTOCOL-ENFORCEMENT'
              rules: [
                {
                  ruleId: '920440'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'RCE'
              rules: [
                {
                  ruleId: '932130'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'SQLI'
              rules: [
                {
                  ruleId: '942410'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942400'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942370'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942300'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942200'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942190'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942180'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942120'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942330'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'XSS'
              rules: [
                {
                  ruleId: '941340'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941320'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941160'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941150'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941100'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName:'PHP'
              rules: [
                {
                  ruleId: '933210'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: [] 
                }
              ]
              exclusions: []
            }
          ]
          exclusions: []
        }
        {
          ruleSetType: 'Microsoft_BotManagerRuleSet'
          ruleSetVersion: '1.0'
          ruleGroupOverrides: []
          exclusions: []
        }
      ]
    }
  }
}

////////////
/// UAT ///
//////////

resource wafpolarisuat 'Microsoft.Network/frontdoorwebapplicationfirewallpolicies@2022-05-01' = {
  name: waf_uat_name
  location: 'Global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    policySettings: {
      enabledState: 'Enabled'
      mode: 'Prevention'
      customBlockResponseStatusCode: 403
      customBlockResponseBody: 'WW91IGFyZSBub3QgYXV0aG9yaXNlZCB0byBhY2Nlc3MgdGhpcyByZXNvdXJjZSwgcGxlYXNlIGNvbnRhY3QgSVQgdG8gcmVxdWVzdCBhY2Nlc3Mu'

      requestBodyCheck: 'Enabled'
    }
    customRules: {
      rules: [
        {
          name: 'IPAllowList'
          enabledState: 'Enabled'
          priority: 100
          ruleType: 'MatchRule'
          rateLimitDurationInMinutes: 1
          rateLimitThreshold: 100
          matchConditions: [
            {
              matchVariable: 'SocketAddr'
              operator: 'IPMatch'
              negateCondition: true
              matchValue: IPAllowListUAT
              transforms: []
            }
          ]
          action: 'Block'
        }
      ]
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'Microsoft_DefaultRuleSet'
          ruleSetVersion: '2.1'
          ruleSetAction: 'Block'
          ruleGroupOverrides: [
            {
              ruleGroupName: 'MS-ThreatIntel-CVEs'
              rules: [
                {
                  ruleId: '99001016'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
                {
                  ruleId: '99001015'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
                {
                  ruleId: '99001014'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'MS-ThreatIntel-WebShells'
              rules: [
                {
                  ruleId: '99005006'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'General'
              rules: [
                {
                  ruleId: '200003'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '200002'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'MS-ThreatIntel-SQLI'
              rules: [
                {
                  ruleId: '99031004'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '99031002'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '99031001'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'PROTOCOL-ATTACK'
              rules: [
                {
                  ruleId: '921200'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'PROTOCOL-ENFORCEMENT'
              rules: [
                {
                  ruleId: '920440'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'RCE'
              rules: [
                {
                  ruleId: '932130'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'SQLI'
              rules: [
                {
                  ruleId: '942410'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942400'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942370'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942300'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942200'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942190'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942180'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942120'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942330'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'XSS'
              rules: [
                {
                  ruleId: '941340'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941320'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941160'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941150'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941100'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName:'PHP'
              rules: [
                {
                  ruleId: '933210'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: [] 
                }
              ]
              exclusions: []
            }
          ]
          exclusions: []
        }
        {
          ruleSetType: 'Microsoft_BotManagerRuleSet'
          ruleSetVersion: '1.0'
          ruleGroupOverrides: []
          exclusions: []
        }
      ]
    }
  
  }
  dependsOn: [wafpolaristest] 
}


/////////////////
/// Training ///
///////////////


resource wafpolaristrn 'Microsoft.Network/FrontDoorWebApplicationFirewallPolicies@2022-05-01' = {
  name: waf_trn_name
  location: 'Global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    policySettings: {
      enabledState: 'Enabled'
      mode: 'Prevention'
      customBlockResponseStatusCode: 403
      customBlockResponseBody: 'WW91IGFyZSBub3QgYXV0aG9yaXNlZCB0byBhY2Nlc3MgdGhpcyByZXNvdXJjZSwgcGxlYXNlIGNvbnRhY3QgSVQgdG8gcmVxdWVzdCBhY2Nlc3Mu'

      requestBodyCheck: 'Enabled'
    }
    customRules: {
      rules: [
        {
          name: 'IPAllowList'
          enabledState: 'Enabled'
          priority: 100
          ruleType: 'MatchRule'
          rateLimitDurationInMinutes: 1
          rateLimitThreshold: 100
          matchConditions: [
            {
              matchVariable: 'SocketAddr'
              operator: 'IPMatch'
              negateCondition: true
              matchValue: IPAllowListTRN
              transforms: []
            }
          ]
          action: 'Block'
        }
      ]
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'Microsoft_DefaultRuleSet'

          ruleSetVersion: '2.1'
          ruleSetAction: 'Block'
          ruleGroupOverrides: [
            {
              ruleGroupName: 'MS-ThreatIntel-CVEs'
              rules: [
                {
                  ruleId: '99001016'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
                {
                  ruleId: '99001015'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
                {
                  ruleId: '99001014'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'MS-ThreatIntel-WebShells'
              rules: [
                {
                  ruleId: '99005006'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'General'
              rules: [
                {
                  ruleId: '200003'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '200002'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'MS-ThreatIntel-SQLI'
              rules: [
                {
                  ruleId: '99031004'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '99031002'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '99031001'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'PROTOCOL-ATTACK'
              rules: [
                {
                  ruleId: '921200'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'PROTOCOL-ENFORCEMENT'
              rules: [
                {
                  ruleId: '920440'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'RCE'
              rules: [
                {
                  ruleId: '932130'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'SQLI'
              rules: [
                {
                  ruleId: '942410'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942400'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942370'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942300'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942200'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942190'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942180'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942120'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942330'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'XSS'
              rules: [
                {
                  ruleId: '941340'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941320'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941160'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941150'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941100'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName:'PHP'
              rules: [
                {
                  ruleId: '933210'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: [] 
                }
              ]
              exclusions: []
            }
          ]
          exclusions: []
        }
        {
          ruleSetType: 'Microsoft_BotManagerRuleSet'
          ruleSetVersion: '1.0'
          ruleGroupOverrides: []
          exclusions: []
        }
      ]
    }
  }
  dependsOn: [wafpolarisuat] 

}


////////////
/// PROD ///
//////////


resource wafpolarisprod 'Microsoft.Network/frontdoorwebapplicationfirewallpolicies@2022-05-01' = {
  name: waf_prod_name
  location: 'Global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    policySettings: {
      enabledState: 'Enabled'
      mode: 'Prevention'
      customBlockResponseStatusCode: 403
      customBlockResponseBody: 'WW91IGFyZSBub3QgYXV0aG9yaXNlZCB0byBhY2Nlc3MgdGhpcyByZXNvdXJjZSwgcGxlYXNlIGNvbnRhY3QgSVQgdG8gcmVxdWVzdCBhY2Nlc3Mu'

      requestBodyCheck: 'Enabled'
    }
    customRules: {
      rules: [
        {
          name: 'IPAllowList'
          enabledState: 'Enabled'
          priority: 100
          ruleType: 'MatchRule'
          rateLimitDurationInMinutes: 1
          rateLimitThreshold: 100
          matchConditions: [
            {
              matchVariable: 'SocketAddr'
              operator: 'IPMatch'
              negateCondition: true
              matchValue: IPAllowListPROD
              transforms: []
            }
          ]
          action: 'Block'
        }
      ]
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'Microsoft_DefaultRuleSet'
          ruleSetVersion: '2.1'
          ruleSetAction: 'Block'
          ruleGroupOverrides: [
            {
              ruleGroupName: 'MS-ThreatIntel-CVEs'
              rules: [
                {
                  ruleId: '99001016'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
                {
                  ruleId: '99001015'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
                {
                  ruleId: '99001014'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'MS-ThreatIntel-WebShells'
              rules: [
                {
                  ruleId: '99005006'
                  enabledState: 'Enabled'
                  action: 'AnomalyScoring'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'General'
              rules: [
                {
                  ruleId: '200003'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '200002'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'MS-ThreatIntel-SQLI'
              rules: [
                {
                  ruleId: '99031004'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '99031002'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '99031001'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'PROTOCOL-ATTACK'
              rules: [
                {
                  ruleId: '921200'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'PROTOCOL-ENFORCEMENT'
              rules: [
                {
                  ruleId: '920440'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'RCE'
              rules: [
                {
                  ruleId: '932130'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'SQLI'
              rules: [
                {
                  ruleId: '942410'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942400'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942370'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942300'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942200'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942190'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942180'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942120'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '942330'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName: 'XSS'
              rules: [
                {
                  ruleId: '941340'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941320'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941160'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941150'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
                {
                  ruleId: '941100'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: []
                }
              ]
              exclusions: []
            }
            {
              ruleGroupName:'PHP'
              rules: [
                {
                  ruleId: '933210'
                  enabledState: 'Enabled'
                  action: 'Log'
                  exclusions: [] 
                }
              ]
              exclusions: []
            }
          ]
          exclusions: []
        }
        {
          ruleSetType: 'Microsoft_BotManagerRuleSet'
          ruleSetVersion: '1.0'
          ruleGroupOverrides: []
          exclusions: []
        }
      ]
    }
  
  }
  dependsOn: [wafpolarisuat] 
}


output wafpolicyidtest string = wafpolaristest.id
output wafpolicytiduat string = wafpolarisuat.id
output wafpolicyidtrn string = wafpolaristrn.id
output wafpolicyidprod string = wafpolarisprod.id
