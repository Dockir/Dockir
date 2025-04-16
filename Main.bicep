resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'vnet'
  location: 'northeurope'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '192.168.1.0/24'
      ]
    }
     subnets: [
       {
        name : 'labsubnet'
        properties: {
          addressPrefix: '192.168.1.0/24'
        }
       }
     ]
  } 
}

resource nic 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: 'labvmnic'
   location: 'northeurope'
    properties: {
       ipConfigurations: [
         {
           name: 'ipconfig1'
           properties: {
             subnet: {
              id: vnet.properties.subnets[0].id
                  }
                }
           }
       ]
      }
    }
    
resource vm 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: 'labvm'
  location: 'northeurope'
   properties: {
     hardwareProfile: {
       vmSize: 'Standard_B1s'
     }
      osProfile: {
        computerName: 'labvm'
        adminUsername: 'mdoadmin'
        adminPassword: 'Softweb2605'
      }
       storageProfile: {
         imageReference: {
          publisher: 'MicrosoftWindowsServer'
          offer: 'WindowsServer'
          sku: '2022-Datacenter'
          version: 'latest'
         }
       }
       networkProfile: { 
        networkInterfaces: [ 
         {
          id: nic.id
         }  
        ] 

       }
   }
}
