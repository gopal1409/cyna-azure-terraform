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
#next we will create nsg\
#lets create nsg and open the port 
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name = "${local.resoure_name_prefix}-nsg"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

#this nsg need to be part of your subnet also
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_associate" {
  subnet_id = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}
locals {
  web_inbound_ports_maps = { #name is web_inbound_ports_maps
    "110" : "22", #expression in key value format
    "120" : "80",
    "130" : "443"
  }
}
#create rules to open port 
resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
    for_each = local.web_inbound_ports_maps
  name                        = "Rule-Port-${each.value}" #rule-port-22
  priority                    = each.key #110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value #22 80 443
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name 
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name 
}
