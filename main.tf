
module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network" {
  source = "./modules/network"

  vnet_name               = "ai-foundry-vnet"
  address_space           = ["10.0.0.0/16"]
  location                = module.resource_group.location
  resource_group_name     = module.resource_group.name
  vm_subnet_name          = "VmSubnet"
  vm_subnet_address_prefixes = ["10.0.1.0/24"]
  bastion_subnet_name     = "AzureBastionSubnet"
  bastion_subnet_address_prefixes = ["10.0.2.0/27"]
  agent_client_subnet_name = "AgentClientSubnet"
  agent_client_subnet_address_prefixes = ["10.0.3.0/24"]
  enable_ddos_protection  = true
}

data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

module "key_vault" {
  source = "./modules/key_vault"

  kv_name             = "aifoundry-kv-${random_string.suffix.result}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  vnet_id             = module.network.vnet_id
  subnet_id           = module.network.vm_subnet_id
}

module "container_registry" {
  source = "./modules/container_registry"

  acr_name            = "aifoundryacr${random_string.suffix.result}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  vnet_id             = module.network.vnet_id
  subnet_id           = module.network.vm_subnet_id
}

module "openai" {
  source = "./modules/openai"

  openai_name         = "aifoundry-openai-${random_string.suffix.result}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  vnet_id             = module.network.vnet_id
  subnet_id           = module.network.vm_subnet_id
}

module "search" {
  source = "./modules/search"

  search_name         = "aifoundry-search-${random_string.suffix.result}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  vnet_id             = module.network.vnet_id
  subnet_id           = module.network.vm_subnet_id
}

module "log_analytics" {
  source = "./modules/log_analytics"

  la_name             = "aifoundry-la-${random_string.suffix.result}"
  ai_name             = "aifoundry-ai-${random_string.suffix.result}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
}

module "storage_account" {
  source = "./modules/storage_account"

  storage_account_name = "aifoundrysa${random_string.suffix.result}"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  subnet_id            = module.network.vm_subnet_id
  vnet_id              = module.network.vnet_id
}

module "azure_sql" {
  source = "./modules/azure_sql"

  sql_server_name   = "aifoundrysql-${random_string.suffix.result}"
  sql_database_name = "aifoundrydb"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sql_admin_login     = "sqladmin"
  sql_admin_password  = var.sql_admin_password
  subnet_id           = module.network.vm_subnet_id
  vnet_id             = module.network.vnet_id
}

module "cosmos_db" {
  source = "./modules/cosmos_db"

  cosmosdb_account_name = "aifoundrycosmosdb-${random_string.suffix.result}"
  resource_group_name   = module.resource_group.name
  location              = module.resource_group.location
  subnet_id             = module.network.vm_subnet_id
  vnet_id               = module.network.vnet_id
}

module "app_storage_account" {
  source = "./modules/app_storage_account"

  app_storage_account_name = "aifoundryappsa${random_string.suffix.result}"
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  subnet_id                = module.network.vm_subnet_id
  vnet_id                  = module.network.vnet_id
}

module "app_service_environment" {
  source = "./modules/app_service_environment"

  ase_name            = "aifoundryase-${random_string.suffix.result}"
  resource_group_name = module.resource_group.name
  subnet_id           = module.network.vm_subnet_id
}

module "api_management" {
  source = "./modules/api_management"

  apim_name           = "aifoundryapim-${random_string.suffix.result}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  subnet_id           = module.network.vm_subnet_id
}

module "application_gateway" {
  source = "./modules/application_gateway"

  ag_name             = "aifoundryag-${random_string.suffix.result}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.network.vm_subnet_id
}

module "jumpbox_vm" {
  source = "./modules/jumpbox_vm"

  vm_name             = "aifoundryjumpbox-${random_string.suffix.result}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.network.vm_subnet_id
  admin_username      = "azureuser"
  admin_password      = var.vm_admin_password
}

module "bastion_host" {
  source = "./modules/bastion_host"

  bastion_host_name   = "aifoundrybastion-${random_string.suffix.result}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.network.bastion_subnet_id
}

module "container_apps_environment" {
  source = "./modules/container_apps_environment"

  ca_env_name                = "aifoundrycaenv-${random_string.suffix.result}"
  location                   = module.resource_group.location
  resource_group_name        = module.resource_group.name
  log_analytics_workspace_id = module.log_analytics.la_id
}

module "service_bus" {
  source = "./modules/service_bus"

  sb_namespace_name   = "aifoundrysb-${random_string.suffix.result}"
  sb_queue_name       = "aifoundryqueue"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.network.vm_subnet_id
  vnet_id             = module.network.vnet_id
}

module "managed_identity" {
  source = "./modules/managed_identity"

  identity_name       = "aifoundry-uai-${random_string.suffix.result}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}












