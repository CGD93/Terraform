data "azurerm_shared_image" "Linux_A" {
  name                = "Linux-A"
  resource_group_name = "CGD-Master"
  gallery_name = "Image_Gallery"
}
data "azurerm_shared_image" "Linux_B" {
  name                = "Linux-B"
  resource_group_name = "CGD-Master"
  gallery_name = "Image_Gallery"
}

#Jump-A

resource "azurerm_virtual_machine" "JB-A" {
  name                  = "JB-A"
  location              = azurerm_resource_group.Jump-Server.location
  resource_group_name   = azurerm_resource_group.Jump-Server.name
  network_interface_ids = [azurerm_network_interface.Jump-A.id]
  vm_size               = "Standard_D2s_v3"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "JB-A-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "JB-A"
    admin_username = "ID"
    admin_password = "Password"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.azure_tag
}

#Jump-B

resource "azurerm_virtual_machine" "JB-B" {
  name                  = "JB-B"
  location              = azurerm_resource_group.Jump-Server.location
  resource_group_name   = azurerm_resource_group.Jump-Server.name
  network_interface_ids = [azurerm_network_interface.Jump-B.id]
  vm_size               = "Standard_D2s_v3"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "JB-B-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

   os_profile {
    computer_name  = "JB-B"
    admin_username = "ID"
    admin_password = "Password"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.azure_tag
}

#Server-A

resource "azurerm_virtual_machine" "Server-A" {
  name                  = "Server-A"
  location              = azurerm_resource_group.server-Zone.location
  resource_group_name   = azurerm_resource_group.server-Zone.name
  network_interface_ids = [azurerm_network_interface.Server-A.id]
  vm_size               = "Standard_D2s_v3"

  storage_image_reference {
    id = data.azurerm_shared_image.Linux_A.id
  }

  storage_os_disk {
    name              = "Sv-A-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

   os_profile {
    computer_name  = "Server-A"
    admin_username = "ID"
    admin_password = "Password"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.azure_tag
}

#Server-A

resource "azurerm_virtual_machine" "Server-B" {
  name                  = "Server-B"
  location              = azurerm_resource_group.server-Zone.location
  resource_group_name   = azurerm_resource_group.server-Zone.name
  network_interface_ids = [azurerm_network_interface.Server-B.id]
  vm_size               = "Standard_D2s_v3"

  storage_image_reference {
    id = data.azurerm_shared_image.Linux_B.id
  }

  storage_os_disk {
    name              = "Sv-B-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

   os_profile {
    computer_name  = "Server-B"
    admin_username = "ID"
    admin_password = "Password"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.azure_tag
}