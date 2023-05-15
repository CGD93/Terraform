resource "azurerm_lb" "CGD-LB" {
  name                = "CGD-LB"
  location            = azurerm_resource_group.server-Zone.location
  resource_group_name = azurerm_resource_group.server-Zone.name
  sku = "Standard"
  frontend_ip_configuration {
    name                 = "CGD_frontend"
    public_ip_address_id = azurerm_public_ip.CGD-LB-Public.id
  }
}

resource "azurerm_lb_backend_address_pool" "CGD-Backend" {
  loadbalancer_id = azurerm_lb.CGD-LB.id
  name            = "Backend_pool"
}

resource "azurerm_lb_backend_address_pool_address" "add-a" {
  name                    = "server-a"
  backend_address_pool_id = azurerm_lb_backend_address_pool.CGD-Backend.id
  virtual_network_id      = azurerm_virtual_network.Server-Vn.id
  ip_address = "10.12.1.9"
}

resource "azurerm_lb_backend_address_pool_address" "add-b" {
  name                    = "server-b"
  backend_address_pool_id = azurerm_lb_backend_address_pool.CGD-Backend.id
  virtual_network_id      = azurerm_virtual_network.Server-Vn.id
  ip_address = "10.12.1.10"
}

resource "azurerm_lb_probe" "CGD-probe" {
 loadbalancer_id     = azurerm_lb.CGD-LB.id
 name                = "CGD-probe"
 port                = "80"
}

resource "azurerm_lb_rule" "CGD-rule" {
  loadbalancer_id                = azurerm_lb.CGD-LB.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  probe_id                       = azurerm_lb_probe.CGD-probe.id
  backend_address_pool_ids = [ azurerm_lb_backend_address_pool.CGD-Backend.id ]
  frontend_ip_configuration_name = "CGD_frontend"
}
