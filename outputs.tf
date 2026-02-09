output "resource_group_name" {
  value = data.azurerm_resource_group.target.name
}

output "databricks_workspace_url" {
  value = module.databricks.workspace_url
}

output "adf_name" {
  value = module.data_factory.name
}

output "synapse_web_endpoint" {
  value = "https://web.azuresynapse.net?workspace=%2fsubscriptions%2f3a72be92-287b-4f1e-840a-5e3e71100139%2fresourceGroups%2f${data.azurerm_resource_group.target.name}%2fproviders%2fMicrosoft.Synapse%2fworkspaces%2f${module.synapse.name}"
  # Note: A real endpoint property might be available, but constructing it is common. 
  # Actually, let's output the name for now.
}

output "synapse_name" {
  value = module.synapse.name
}

output "function_app_name" {
  value = module.functions.name
}

output "function_app_default_hostname" {
  value = module.functions.default_hostname
}

output "cosmosdb_endpoint" {
  value = module.cosmosdb.endpoint
}

output "eventhub_namespace" {
  value = module.eventhub.name
}

output "synapse_sql_admin_password" {
  value     = random_password.sql_password.result
  sensitive = true
}
