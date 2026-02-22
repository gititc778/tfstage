output "eventhub_namespace_name" {
  value = azurerm_eventhub_namespace.ns.name
}

output "eventhub_name" {
  value = azurerm_eventhub.hub.name
}

output "eventhub_connection_string" {
  value     = azurerm_eventhub_namespace.ns.default_primary_connection_string
  sensitive = true
}