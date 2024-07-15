resource "azurerm_resource_group" "rg" {
  #3inside the resource this are the argument we have
  name     = var.resource_group_name
  location = var.resource_group_location
}