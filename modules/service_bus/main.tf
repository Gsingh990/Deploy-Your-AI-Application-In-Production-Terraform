
resource "azurerm_servicebus_namespace" "sb_namespace" {
  name                = var.sb_namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Premium"

  tags = {
    environment = "production"
  }
}

resource "azurerm_servicebus_queue" "sb_queue" {
  name                = var.sb_queue_name
  namespace_id        = azurerm_servicebus_namespace.sb_namespace.id
  partitioning_enabled = true
}

resource "azurerm_private_endpoint" "sb_pe" {
  name                = "${var.sb_namespace_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.sb_pdnsz.id]
  }

  private_service_connection {
    name                           = "${var.sb_namespace_name}-psc"
    private_connection_resource_id = azurerm_servicebus_namespace.sb_namespace.id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
  }
}

resource "azurerm_private_dns_zone" "sb_pdnsz" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sb_pdnsz_link" {
  name                  = "${var.sb_namespace_name}-pdnsz-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sb_pdnsz.name
  virtual_network_id    = var.vnet_id
}
