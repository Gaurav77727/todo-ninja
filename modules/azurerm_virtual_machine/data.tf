data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}


data "azurerm_public_ip" "pip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
}

data "azurerm_client_config" "current" {}

