resource "azurerm_virtual_network" "example" {
  name                = "myvnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space  
  tags = {
    environment = "Production"
  }
}