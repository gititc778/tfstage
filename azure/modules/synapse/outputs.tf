output "workspace_id" {
  value = azurerm_synapse_workspace.syn.id
}

output "workspace_name" {
  value = azurerm_synapse_workspace.syn.name
}

output "workspace_endpoint" {
  value = azurerm_synapse_workspace.syn.connectivity_endpoints
}