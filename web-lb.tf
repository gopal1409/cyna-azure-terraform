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

##backendpool
resource "azurerm_lb_backend_address_pool" "web_lb_pool" {
  name                = "${local.resoure_name_prefix}-backendpool"
  loadbalancer_id = azurerm_lb.web_lb.id 
}

#probe
resource "azurerm_lb_probe" "web_lb_probe" {
   name                = "${local.resoure_name_prefix}-weblbprobe"
   protocol = "Tcp"
   port = "80"
   loadbalancer_id = azurerm_lb.web_lb.id 
   interval_in_seconds = 15
   number_of_probes = 4 
}

#but i need to definet he rule how the probe is going to work
resource "azurerm_lb_rule" "web_rule" {
  name                = "${local.resoure_name_prefix}-rule"
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name 
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_lb_pool.id]
  probe_id = azurerm_lb_probe.web_lb_probe.id 
  loadbalancer_id = azurerm_lb.web_lb.id 
}

resource "azurerm_network_interface_backend_address_pool_association" "web_lb_associate" {
  for_each = var.web_linux_instance_count
  network_interface_id = azurerm_network_interface.web_linux_nic[each.key].id 
  ip_configuration_name = azurerm_network_interface.web_linux_nic[each.key].ip_configuration[0].name 
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_pool.id 
}