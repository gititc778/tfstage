output "cosmos_account_name" {
  value = azurerm_cosmosdb_account.db.name
}

output "cosmos_account_endpoint" {
  value = azurerm_cosmosdb_account.db.endpoint
}

output "cosmos_primary_key" {
  value     = azurerm_cosmosdb_account.db.primary_key
  sensitive = true
}

output "cosmos_sql_database_name" {
  value = azurerm_cosmosdb_sql_database.sql_db.name
}