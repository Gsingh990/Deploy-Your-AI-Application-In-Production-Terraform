
resource "azurerm_log_analytics_workspace" "la" {
  name                = var.la_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
}

resource "azurerm_application_insights" "ai" {
  name                = var.ai_name
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.la.id
  application_type    = "web"
}
