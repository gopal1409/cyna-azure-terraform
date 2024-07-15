resource "azurerm_subnet" "websubnet" {
  name = "${local.resoure_name_prefix}-${var.web_subnet_name}"
  resource_group_name = azurerm_resource_group.rg.name #once the subnet get created it should be part of your resource group
  virtual_network_name = azurerm_virtual_network.vpc.name #subnet should be part of your vnet also
  address_prefixes = var.web_subnet_address
  
}

resource "azurerm_subnet" "dbsubnet" {
  name =  "${local.resoure_name_prefix}-${var.db_subnet_name}"
  resource_group_name = azurerm_resource_group.rg.name 
  virtual_network_name = azurerm_virtual_network.vpc.name 
  address_prefixes = var.db_subnet_address
}