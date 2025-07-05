module "resource_group" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = "rg-todoapp"
  resource_group_location = "centralindia"
}


module "virtual_network" {
  depends_on               = [module.resource_group]
  source                   = "../modules/azurerm_virtual_network"
  virtual_network_name     = "vnet-todoapp"
  virtual_network_location = "centralindia"
  resource_group_name      = "rg-todoapp"
  address_space            = ["10.0.0.0/16"]
}

module "frontend_subnet" {
  depends_on           = [module.virtual_network]
  source               = "../modules/azurerm_subnet"
  resource_group_name  = "rg-todoapp"
  virtual_network_name = "vnet-todoapp"
  subnet_name          = "frontend-subnet"
  address_prefixes     = ["10.0.1.0/24"]
}

# module "backend_subnet" {
#   depends_on           = [module.virtual_network]
#   source               = "../modules/azurerm_subnet"
#   resource_group_name  = "rg-todoapp"
#   virtual_network_name = "vnet-todoapp"
#   subnet_name          = "backend-subnet"
#   address_prefixes     = ["10.0.7.0/24"]
# }

module "public_ip_frontend" {
  depends_on          = [module.resource_group]
  source              = "../modules/azurerm_public_ip"
  public_ip_name      = "pip-todoapp-frontend"
  resource_group_name = "rg-todoapp"
  location            = "centralindia"
  allocation_method   = "Dynamic"
}

module "frontend_vm" {
  depends_on           = [module.frontend_subnet]
  source               = "../modules/azurerm_virtual_machine"
  resource_group_name  = "rg-todoapp"
  location             = "centralindia"
  vm_name              = "todo-frontend-vm"
  vm_size              = "Standard_B1s"
  admin_username       = "username"
  admin_password       = "password"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-jammy"
  image_sku            = "22_04-lts"
  image_version        = "latest"
  nic_name             = "nic-vm-frontend"
  virtual_network_name = "vnet-todoapp"
  subnet_name          = "frontend-subnet"
  public_ip_name       = "pip-todoapp-frontend"
  keyvault_name        = "key-todoapp123"
}


# module "public_ip_backend" {
#   depends_on          = [module.resource_group]
#   source              = "../modules/azurerm_public_ip"
#   public_ip_name      = "pip-todoapp-backend"
#   resource_group_name = "rg-todoapp"
#   location            = "centralindia"
#   allocation_method   = "Static"
# }


# module "backend_vm" {
#   depends_on           = [module.backend_subnet]
#   source               = "../modules/azurerm_virtual_machine"
#   resource_group_name  = "rg-todoapp"
#   location             = "centralindia"
#   vm_name              = "todo-backend-vm"
#   vm_size              = "Standard_B1s"
#   admin_username       = "username"
#   admin_password       = "password"
#   image_publisher      = "Canonical"
#   image_offer          = "0001-com-ubuntu-server-jammy"
#   image_sku            = "22_04-lts"
#   image_version        = "latest"
#   nic_name             = "nic-vm-backend"
#   virtual_network_name = "vnet-todoapp"
#   subnet_name          = "backend-subnet"
#   pip_name             = "pip-todoapp-backend"
#   keyvault_name        = "kv-todoapp"
# }

# module "sql_server" {
#   depends_on                   = [module.backend_subnet]
#   source                       = "../modules/azurerm_sql_server"
#   sql_server_name              = "sqlserver-todoapp"
#   resource_group_name          = "rg-todoapp"
#   location                     = "centralindia"
#   administrator_login          = "sqladmin"
#   administrator_login_password = "SqlAdmin@1234567"
# }

# module "sql_database" {
#   depends_on = [module.sql_server]
#   source     = "../modules/azurerm_sql_database"

#   sql_database_name = "todoappdb"
#   sql_server_id     = 
# }
