variable "virtual_network_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "virtual_network_location" {
  description = "Azure region where the VNet will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network"
  type        = list(string)
}

