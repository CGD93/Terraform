#Private

#Jump
resource "azurerm_network_interface" "Jump-A" {
  name                = "CGD-JumpA-nic"
  location            = azurerm_resource_group.Jump-Server.location
  resource_group_name = azurerm_resource_group.Jump-Server.name
  
  ip_configuration {
    name                          = "Jump-A"
    subnet_id                     = azurerm_subnet.jump-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.jb-a
    public_ip_address_id = azurerm_public_ip.CGD-JumpA-Public.id
  }
  tags = var.azure_tag
}

resource "azurerm_network_interface" "Jump-B" {
  name                = "CGD-JumpB-nic"
  location            = azurerm_resource_group.Jump-Server.location
  resource_group_name = azurerm_resource_group.Jump-Server.name

  ip_configuration {
    name                          = "Jump-B"
    subnet_id                     = azurerm_subnet.jump-subnet.id
    private_ip_address_allocation = "Static" 
    private_ip_address = var.jb-b
    public_ip_address_id = azurerm_public_ip.CGD-JumpB-Public.id
  }
  tags = var.azure_tag
}

#Server
resource "azurerm_network_interface" "Server-A" {
  name                = "CGD-ServerA-nic"
  location            = azurerm_resource_group.server-Zone.location
  resource_group_name = azurerm_resource_group.server-Zone.name

  ip_configuration {
    name                          = "Server-A"
    subnet_id                     = azurerm_subnet.server-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.sv-a
    public_ip_address_id = azurerm_public_ip.CGD-ServerA-Public.id
  }
  tags = var.azure_tag
}

resource "azurerm_network_interface" "Server-B" {
  name                = "CGD-ServerB-nic"
  location            = azurerm_resource_group.server-Zone.location
  resource_group_name = azurerm_resource_group.server-Zone.name

  ip_configuration {
    name                          = "Server-B"
    subnet_id                     = azurerm_subnet.server-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.sv-b
    public_ip_address_id = azurerm_public_ip.CGD-ServerB-Public.id
  }
  tags = var.azure_tag
}

#Public

resource "azurerm_public_ip" "CGD-JumpA-Public" {
  name                = "CDG_Pu-JumpA"
  resource_group_name = azurerm_resource_group.Jump-Server.name
  location            = azurerm_resource_group.Jump-Server.location
  allocation_method   = "Dynamic"
  tags = var.azure_tag
}

resource "azurerm_public_ip" "CGD-JumpB-Public" {
  name                = "CDG_Pu-JumpB"
  resource_group_name = azurerm_resource_group.Jump-Server.name
  location            = azurerm_resource_group.Jump-Server.location
  allocation_method   = "Dynamic"
  tags = var.azure_tag
}

#Server-A
resource "azurerm_public_ip" "CGD-ServerA-Public" {
  name                = "CDG_Pu-ServerA"
  resource_group_name = azurerm_resource_group.server-Zone.name
  location            = azurerm_resource_group.server-Zone.location
  allocation_method   = "Dynamic"
  tags = var.azure_tag
}

#Server-B
resource "azurerm_public_ip" "CGD-ServerB-Public" {
  name                = "CDG_Pu-ServerB"
  resource_group_name = azurerm_resource_group.server-Zone.name
  location            = azurerm_resource_group.server-Zone.location
  allocation_method   = "Dynamic"
  tags = var.azure_tag
}

resource "azurerm_public_ip" "CGD-LB-Public" {
  name                = "CDG_Pu-LB"
  resource_group_name = azurerm_resource_group.server-Zone.name
  location            = azurerm_resource_group.server-Zone.location
  allocation_method   = "Static"
  sku = "Standard"
  tags = var.azure_tag
}