
output "id" {
  value = azurerm_storage_account.sa.id
}

output "name" {
  value = azurerm_storage_account.sa.name
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.sa_pdnsz.id
}
