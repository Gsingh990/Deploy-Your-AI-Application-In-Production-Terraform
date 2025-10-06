
output "id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "name" {
  value = azurerm_linux_virtual_machine.vm.name
}

output "private_ip_address" {
  value = azurerm_network_interface.nic.private_ip_address
}
