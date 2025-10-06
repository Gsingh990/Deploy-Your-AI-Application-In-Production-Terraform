resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.ddos_plan[0].id
    enable = var.enable_ddos_protection
  }
}

resource "azurerm_subnet" "vm_subnet" {
  name                 = var.vm_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.vm_subnet_address_prefixes
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = var.bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_subnet_address_prefixes
}

resource "azurerm_subnet" "agent_client_subnet" {
  name                 = var.agent_client_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.agent_client_subnet_address_prefixes
}

resource "azurerm_network_ddos_protection_plan" "ddos_plan" {
  count               = var.enable_ddos_protection ? 1 : 0
  name                = var.ddos_protection_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
}