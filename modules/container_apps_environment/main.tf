
resource "azurerm_container_app_environment" "ca_env" {
  name                = var.ca_env_name
  location            = var.location
  resource_group_name = var.resource_group_name
  log_analytics_workspace_id = var.log_analytics_workspace_id

  tags = {
    environment = "production"
  }
}
