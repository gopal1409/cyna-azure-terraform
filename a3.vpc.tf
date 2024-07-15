resource "azurerm_virtual_network" "example" {
  name                = "myvnet"
  location            = azurerm_resource_group.rg.location #us2
  resource_group_name = azurerm_resource_group.rg.name #cyan-rg
  address_space       = var.vnet_address_space  
  tags = {
    environment = "Production"
  }
}