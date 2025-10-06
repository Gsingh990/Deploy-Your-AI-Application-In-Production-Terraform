output "resource_group_name" {
  value = module.resource_group.name
}

output "virtual_network_name" {
  value = module.network.vnet_name
}

output "key_vault_name" {
  value = module.key_vault.name
}

output "container_registry_name" {
  value = module.container_registry.name
}

output "openai_service_name" {
  value = module.openai.name
}

output "search_service_name" {
  value = module.search.name
}

output "log_analytics_workspace_name" {
  value = module.log_analytics.la_name
}

output "application_insights_name" {
  value = module.log_analytics.ai_name
}