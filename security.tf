#Jump-A
resource "azurerm_network_security_group" "CGD-JumpA_nsg" {
  name                = "CGD-JumpA-nsg"
  location            = azurerm_resource_group.Jump-Server.location
  resource_group_name = azurerm_resource_group.Jump-Server.name
  tags = var.azure_tag
  security_rule {
    name                       = "Local-to-SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.Local_ip
    destination_address_prefix = "10.11.1.9"
  }/*
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.jb-a
    destination_address_prefixes = [ "10.12.1.10","10.12.1.9" ]
  }*/
}

resource "azurerm_network_interface_security_group_association" "Jump-A" {
  network_interface_id      = azurerm_network_interface.Jump-A.id
  network_security_group_id = azurerm_network_security_group.CGD-JumpA_nsg.id
}

#Jump-B
resource "azurerm_network_security_group" "CGD-JumpB_nsg" {
  name                = "CGD-JumpB-nsg"
  location            = azurerm_resource_group.Jump-Server.location
  resource_group_name = azurerm_resource_group.Jump-Server.name
  tags = var.azure_tag
  security_rule {
    name                       = "Local-to-SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.Local_ip
    destination_address_prefix = "10.11.1.10"
  }/*
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.jb-b
    destination_address_prefix = var.sv-b
  }*/
}

resource "azurerm_network_interface_security_group_association" "Jump-B" {
  network_interface_id      = azurerm_network_interface.Jump-B.id
  network_security_group_id = azurerm_network_security_group.CGD-JumpB_nsg.id
}

#Server-A
resource "azurerm_network_security_group" "CGD-ServerA_nsg" {
  name                = "CGD-ServerA-nsg"
  location            = azurerm_resource_group.server-Zone.location
  resource_group_name = azurerm_resource_group.server-Zone.name
  tags = var.azure_tag

  security_rule {
    name                       = "SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.jb-a
    destination_address_prefix = var.sv-a
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = var.sv-a
  }
  
}
resource "azurerm_network_interface_security_group_association" "Server-A" {
  network_interface_id      = azurerm_network_interface.Server-A.id
  network_security_group_id = azurerm_network_security_group.CGD-ServerA_nsg.id
}

#Server-B
resource "azurerm_network_security_group" "CGD-ServerB_nsg" {
  name                = "CGD-ServerB-nsg"
  location            = azurerm_resource_group.server-Zone.location
  resource_group_name = azurerm_resource_group.server-Zone.name
  tags = var.azure_tag

  security_rule {
    name                       = "SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes = [ "10.11.1.9","10.11.1.10" ]
    destination_address_prefix = var.sv-b
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = var.sv-b
  }
}
resource "azurerm_network_interface_security_group_association" "Server-B" {
  network_interface_id      = azurerm_network_interface.Server-B.id
  network_security_group_id = azurerm_network_security_group.CGD-ServerB_nsg.id
}