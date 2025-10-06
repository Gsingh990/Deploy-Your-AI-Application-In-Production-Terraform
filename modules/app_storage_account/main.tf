
resource "azurerm_storage_account" "app_sa" {
  name                     = var.app_storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = [var.subnet_id]
    bypass                     = ["AzureServices"]
  }

  tags = {
    environment = "production"
    purpose     = "app_storage"
  }
}

resource "azurerm_private_endpoint" "app_sa_pe" {
  name                = "${var.app_storage_account_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.app_sa_pdnsz.id]
  }

  private_service_connection {
    name                           = "${var.app_storage_account_name}-psc"
    private_connection_resource_id = azurerm_storage_account.app_sa.id
    is_manual_connection           = false
    subresource_names              = ["blob", "queue", "table", "file"]
  }
}

resource "azurerm_private_dns_zone" "app_sa_pdnsz" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "app_sa_pdnsz_link" {
  name                  = "${var.app_storage_account_name}-pdnsz-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.app_sa_pdnsz.name
  virtual_network_id    = var.vnet_id
}
