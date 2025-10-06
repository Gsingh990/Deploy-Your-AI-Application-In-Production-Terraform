
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false
}

resource "azurerm_private_dns_zone" "acr_pdnsz" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr_pdnsz_link" {
  name                  = "${var.acr_name}-pdnsz-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.acr_pdnsz.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_endpoint" "acr_pe" {
  name                = "${var.acr_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.acr_pdnsz.id]
  }

  private_service_connection {
    name                           = "${var.acr_name}-psc"
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
}
