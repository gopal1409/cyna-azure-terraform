resource "azurerm_network_interface" "web_linux_nic" {
    for_each = var.web_linux_instance_count
  name                = "${local.resoure_name_prefix}-nic-${each.key}"
   #sap-hr-vnet
  location            = azurerm_resource_group.rg.location #us2
  resource_group_name = azurerm_resource_group.rg.name #cyan-rg
  ip_configuration {
    name ="web-linux-ip"
    subnet_id = azurerm_subnet.websubnet.id 
    private_ip_address_allocation = "Dynamic"
  }
}