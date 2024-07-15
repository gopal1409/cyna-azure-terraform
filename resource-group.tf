resource "azurerm_resource_group" "rg" {
  #3inside the resource this are the argument we have
  name     =  "${local.resoure_name_prefix}-${var.resource_group_name}"
  location = var.resource_group_location
  tags = local.common_tags
}