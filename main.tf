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
  subnet_name             = "default"
  subnet_address_prefixes = ["10.0.1.0/24"]
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
  subnet_id           = module.network.subnet_id
}

module "container_registry" {
  source = "./modules/container_registry"

  acr_name            = "aifoundryacr${random_string.suffix.result}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  vnet_id             = module.network.vnet_id
  subnet_id           = module.network.subnet_id
}

module "openai" {
  source = "./modules/openai"

  openai_name         = "aifoundry-openai-${random_string.suffix.result}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  vnet_id             = module.network.vnet_id
  subnet_id           = module.network.subnet_id
}

module "search" {
  source = "./modules/search"

  search_name         = "aifoundry-search-${random_string.suffix.result}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  vnet_id             = module.network.vnet_id
  subnet_id           = module.network.subnet_id
}

module "log_analytics" {
  source = "./modules/log_analytics"

  la_name             = "aifoundry-la-${random_string.suffix.result}"
  ai_name             = "aifoundry-ai-${random_string.suffix.result}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
}