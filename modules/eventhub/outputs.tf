output "id" {
  value = azurerm_eventhub_namespace.evh_ns.id
}

output "name" {
  value = azurerm_eventhub_namespace.evh_ns.name
}

output "eventhub_name" {
  value = azurerm_eventhub.evh.name
}
