output "function_app_name" {
  value = azurerm_linux_function_app.func.name
}

output "default_hostname" {
  value = azurerm_linux_function_app.func.default_hostname
}