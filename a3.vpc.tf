resource "azurerm_virtual_network" "vpc" {
  name                = "${local.resoure_name_prefix}-${var.vnet_name}"
   #sap-hr-vnet
  location            = azurerm_resource_group.rg.location #us2
  resource_group_name = azurerm_resource_group.rg.name #cyan-rg
  address_space       = var.vnet_address_space  
  tags = local.common_tags
}