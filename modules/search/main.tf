
resource "azurerm_search_service" "search" {
  name                = var.search_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "standard"
}

resource "azurerm_private_dns_zone" "search_pdnsz" {
  name                = "privatelink.search.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "search_pdnsz_link" {
  name                  = "${var.search_name}-pdnsz-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.search_pdnsz.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_endpoint" "search_pe" {
  name                = "${var.search_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.search_pdnsz.id]
  }

  private_service_connection {
    name                           = "${var.search_name}-psc"
    private_connection_resource_id = azurerm_search_service.search.id
    is_manual_connection           = false
    subresource_names              = ["searchService"]
  }
}
