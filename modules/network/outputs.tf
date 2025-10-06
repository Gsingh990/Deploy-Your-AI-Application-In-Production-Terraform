output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vm_subnet_id" {
  value = azurerm_subnet.vm_subnet.id
}

output "vm_subnet_name" {
  value = azurerm_subnet.vm_subnet.name
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion_subnet.id
}

output "bastion_subnet_name" {
  value = azurerm_subnet.bastion_subnet.name
}

output "agent_client_subnet_id" {
  value = azurerm_subnet.agent_client_subnet.id
}

output "agent_client_subnet_name" {
  value = azurerm_subnet.agent_client_subnet.name
}

output "ddos_protection_plan_id" {
  value = var.enable_ddos_protection ? azurerm_network_ddos_protection_plan.ddos_plan[0].id : null
}