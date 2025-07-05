resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    public_ip_address_id          = data.azurerm_public_ip.pip.id
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}



resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = resource.azurerm_key_vault_secret.secret1.value
  admin_password                  = resource.azurerm_key_vault_secret.secret2.value
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic.id,]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}
resource "azurerm_key_vault" "Keynew" {
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
  
    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get","Set"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_secret" "secret1" {
  name         = "username"
  value        = "gaurav"
  key_vault_id = azurerm_key_vault.Keynew.id
}

resource "azurerm_key_vault_secret" "secret2" {
  name         = "password"
  value        = "Admin@1234567"
  key_vault_id = azurerm_key_vault.Keynew.id
}