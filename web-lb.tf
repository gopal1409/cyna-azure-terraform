##i need to first create a public ip
resource "azurerm_public_ip" "web_lb_publicip" {
  name                = "${local.resoure_name_prefix}-publicip"
  location            = azurerm_resource_group.rg.location #us2
  resource_group_name = azurerm_resource_group.rg.name #cyan-rg
  allocation_method = "Static"
  sku = "Standard" #premium #the public ip will be created in a specific region
  #premium the public ip will be spread across region
  tags = local.common_tags
}

#now we will create teh lb
resource "azurerm_lb" "web_lb" {
  name                = "${local.resoure_name_prefix}-weblb"
  location            = azurerm_resource_group.rg.location #us2
  resource_group_name = azurerm_resource_group.rg.name #cyan-rg
  sku = "Standard"
  #now this lb need to attach with public ip 
  frontend_ip_configuration {
    name = "lbip"
    public_ip_address_id = azurerm_public_ip.web_lb_publicip.id
  }
}

