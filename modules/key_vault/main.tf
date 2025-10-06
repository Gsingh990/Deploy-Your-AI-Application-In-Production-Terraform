
resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "premium"
  soft_delete_retention_days  = 7
  enable_rbac_authorization = true
}

resource "azurerm_private_dns_zone" "kv_pdnsz" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "kv_pdnsz_link" {
  name                  = "${var.kv_name}-pdnsz-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.kv_pdnsz.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_endpoint" "kv_pe" {
  name                = "${var.kv_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv_pdnsz.id]
  }

  private_service_connection {
    name                           = "${var.kv_name}-psc"
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
}
