variable "location" {
  description = "Azure region"
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-todoapp"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "todo-frontend-vm"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "devopsadmin"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  default     = "Admin@1234567"
  sensitive   = true
}

variable "nic_name" {
  description = "Name of the Network Interface"
  type        = string
  default     = "nic-todoappvm"
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_F2"
}

variable "image_publisher" {
  type        = string
  description = "The publisher of the image"
}

variable "image_offer" {
  type        = string
  description = "The offer of the image"
}

variable "image_sku" {
  type        = string
  description = "The SKU of the image"
}

variable "image_version" {
  type        = string
  description = "The version of the image"
}

variable "virtual_network_name" {
  description = "Vnet ka naam"
  type        = string
}

variable "subnet_name" {
  description = "subnet ka naam"
  type        = string
}

variable "public_ip_name" {
  description = "pip ka naam"
  type        = string
}
variable "keyvault_name" {
  description = "Name of the Key Vault"
  type        = string
}
