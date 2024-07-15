resource "azurerm_linux_virtual_machine" "linuxvm" {
  for_each = var.web_linux_instance_count
  name                = "${local.resoure_name_prefix}-nic-${each.key}"
   #sap-hr-vnet
  location            = azurerm_resource_group.rg.location #us2
  resource_group_name = azurerm_resource_group.rg.name #cyan-rg
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password = "Admin@12345678"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.web_linux_nic[each.key].id,
  ]

  
  os_disk {
    name = "osdisk-${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app/app.sh")
}