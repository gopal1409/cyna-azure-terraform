##vnet name 
variable "vnet_name" {
  description = "virtual network name"
  type = string
  #it will accept single string value
  default = "vnet-default"
}

variable "vnet_address_space" {
  description = "vnet address space"
  type = list(string)
  #it is like an array
  default = [ "10.0.0.0/16" ]
}

#
variable "web_subnet_name" {
  type = string 
  default = "websubnet"
}

variable "web_subnet_address" {
  type = list(string)
  default = [ "10.0.1.0/24" ]
}

variable "db_subnet_name" {
  type = string 
  default = "dbsubnet"
}

variable "db_subnet_address" {
  type = list(string)
  default = [ "10.0.2.0/24" ]
}