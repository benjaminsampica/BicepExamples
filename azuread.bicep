resource server_resource 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: uniqueString('sql', resourceGroup().id)
  location: resourceGroup().location
  properties: {
    administrators: {
      login: 'TestGroup'
      sid: '5a6cd1df-dbe0-41f3-8423-efc8205d28dd'
      tenantId: subscription().tenantId
      principalType: 'Group'
      azureADOnlyAuthentication: true
    }
  }
}
