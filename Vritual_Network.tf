resource "azurerm_virtual_network" "Jump-Vn" {
  name                = "CGD-Jump-Vn"
  resource_group_name = azurerm_resource_group.Jump-Server.name
  location            = azurerm_resource_group.Jump-Server.location
  address_space       = ["10.11.1.0/24"]
  tags = var.azure_tag
}

resource "azurerm_virtual_network" "Server-Vn" {
  name                = "CGD-Server-Vn"
  resource_group_name = azurerm_resource_group.server-Zone.name
  location            = azurerm_resource_group.server-Zone.location
  address_space       = ["10.12.1.0/24"]
  tags = var.azure_tag
}

resource "azurerm_subnet" "jump-subnet" {
  name = "Sub-A"
  resource_group_name = azurerm_resource_group.Jump-Server.name
  virtual_network_name = azurerm_virtual_network.Jump-Vn.name
  address_prefixes = ["10.11.1.0/25"]  
}

resource "azurerm_subnet" "server-subnet" {
  name = "Sub-A"
  resource_group_name = azurerm_resource_group.server-Zone.name
  virtual_network_name = azurerm_virtual_network.Server-Vn.name
  address_prefixes = ["10.12.1.0/25"]  
}



#Peering
resource "azurerm_virtual_network_peering" "peering-jb" {
  name                         = "Peering_CGD_jb"
  resource_group_name          = azurerm_resource_group.Jump-Server.name
  virtual_network_name         = azurerm_virtual_network.Jump-Vn.name
  remote_virtual_network_id    = azurerm_virtual_network.Server-Vn.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}

resource "azurerm_virtual_network_peering" "peering-sv" {
  name                         = "Peering_CGD_sv"
  resource_group_name          = azurerm_resource_group.server-Zone.name
  virtual_network_name         = azurerm_virtual_network.Server-Vn.name
  remote_virtual_network_id    = azurerm_virtual_network.Jump-Vn.id
  allow_virtual_network_access = false
  allow_forwarded_traffic      = false

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}