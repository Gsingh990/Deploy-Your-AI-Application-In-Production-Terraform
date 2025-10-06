
resource "azurerm_user_assigned_identity" "uai" {
  name                = var.identity_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = {
    environment = "production"
  }
}
