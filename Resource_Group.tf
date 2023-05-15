resource "azurerm_resource_group" "server-Zone" {
  name     = "CGD-RG-Server"
  location = "Korea Central"
  tags = var.azure_tag
}

resource "azurerm_resource_group" "Jump-Server" {
  name     = "CGD-RG-Jump"
  location = "Korea Central"
  tags = var.azure_tag
}