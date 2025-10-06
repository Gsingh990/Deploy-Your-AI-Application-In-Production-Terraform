
output "la_id" {
  value = azurerm_log_analytics_workspace.la.id
}

output "la_name" {
  value = azurerm_log_analytics_workspace.la.name
}

output "ai_id" {
  value = azurerm_application_insights.ai.id
}

output "ai_name" {
  value = azurerm_application_insights.ai.name
}

output "ai_instrumentation_key" {
  value = azurerm_application_insights.ai.instrumentation_key
  sensitive = true
}
