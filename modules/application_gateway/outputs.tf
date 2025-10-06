
output "id" {
  value = azurerm_application_gateway.ag.id
}

output "name" {
  value = azurerm_application_gateway.ag.name
}

output "public_ip_address" {
  value = azurerm_public_ip.ag_public_ip.ip_address
}
