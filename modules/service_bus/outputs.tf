
output "namespace_id" {
  value = azurerm_servicebus_namespace.sb_namespace.id
}

output "namespace_name" {
  value = azurerm_servicebus_namespace.sb_namespace.name
}

output "queue_id" {
  value = azurerm_servicebus_queue.sb_queue.id
}

output "queue_name" {
  value = azurerm_servicebus_queue.sb_queue.name
}
