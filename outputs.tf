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

output "storage_account_name" {
  value = module.storage_account.name
}

output "sql_server_name" {
  value = module.azure_sql.sql_server_name
}

output "sql_database_name" {
  value = module.azure_sql.sql_database_name
}

output "cosmosdb_account_name" {
  value = module.cosmos_db.name
}

output "app_storage_account_name" {
  value = module.app_storage_account.name
}

output "app_service_environment_name" {
  value = module.app_service_environment.name
}

output "api_management_name" {
  value = module.api_management.name
}

output "api_management_gateway_url" {
  value = module.api_management.gateway_url
}

output "application_gateway_name" {
  value = module.application_gateway.name
}

output "application_gateway_public_ip" {
  value = module.application_gateway.public_ip_address
}

output "jumpbox_vm_name" {
  value = module.jumpbox_vm.name
}

output "jumpbox_vm_private_ip" {
  value = module.jumpbox_vm.private_ip_address
}

output "bastion_host_name" {
  value = module.bastion_host.name
}

output "container_apps_environment_name" {
  value = module.container_apps_environment.name
}

output "service_bus_namespace_name" {
  value = module.service_bus.namespace_name
}

output "service_bus_queue_name" {
  value = module.service_bus.queue_name
}

output "managed_identity_name" {
  value = module.managed_identity.name
}

output "managed_identity_principal_id" {
  value = module.managed_identity.principal_id
}