############################################
# Storage Account (Required for Functions)
############################################
resource "azurerm_storage_account" "func_storage" {
  name                     = lower(replace(var.name, "-", "")) # must be lowercase, no hyphens
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

############################################
# App Service Plan (Consumption)
############################################
resource "azurerm_service_plan" "func_plan" {
  name                = "${var.name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "Y1" # Consumption plan

  tags = var.tags
}

############################################
# Function App
############################################
resource "azurerm_linux_function_app" "func" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  service_plan_id            = azurerm_service_plan.func_plan.id
  storage_account_name       = azurerm_storage_account.func_storage.name
  storage_account_access_key = azurerm_storage_account.func_storage.primary_access_key

  site_config {}

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}