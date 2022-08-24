resource ehnamespace 'Microsoft.EventHub/namespaces@2018-01-01-preview' = {
  name: 'ehnamespaceasdasdasd'
  location: resourceGroup().location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
  }
}

resource eh 'Microsoft.EventHub/namespaces/eventhubs@2017-04-01' = {
  parent: ehnamespace
  name: ehnamespace.name
}

resource sqlServer 'Microsoft.Sql/servers@2019-06-01-preview' = {
  location: resourceGroup().location
  name: 'benjaminsampicasqlserver'
  properties: {
    administratorLogin: 'username'
    administratorLoginPassword: '123asdasd@!!asd'
    version: '12.0'
  }

  resource masterSqlServerDatabase 'databases@2019-06-01-preview' = {
    location: resourceGroup().location
    name: 'master'
    properties: {
    }
  }
}

var diagnosticSettingsName = 'diagnostic-${uniqueString(resourceGroup().id)}'
resource sqlServerDiagnosticSettings 'Microsoft.Sql/servers/databases/providers/diagnosticSettings@2017-05-01-preview' = {
  name: '${sqlServer.name}/master/microsoft.insights/${diagnosticSettingsName}'
  properties: {
    name: diagnosticSettingsName
    eventHubAuthorizationRuleId: resourceId('Microsoft.EventHub/namespaces/authorizationRules', ehnamespace.name, 'RootManageSharedAccessKey')
    eventHubName: eh.name
    logs: [
      {
        category: 'SQLSecurityAuditEvents'
        enabled: true
        retentionPolicy: {
          days: 0
          enabled: false
        }
      }
    ]
  }
}
