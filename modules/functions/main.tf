resource "azurerm_storage_account" "func_sa" {
  name                     = "stfunc${random_string.storage_suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "asp" {
  name                = "asp-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux" # or Windows
  sku_name            = "Y1"    # Consumption plan
}

resource "azurerm_linux_function_app" "func" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.asp.id
  storage_account_name       = azurerm_storage_account.func_sa.name
  storage_account_access_key = azurerm_storage_account.func_sa.primary_access_key

  site_config {
    application_stack {
      python_version = "3.9" # Example stack
    }
  }

  tags = var.tags
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "random_string" "storage_suffix" {
  length  = 13
  special = false
  upper   = false
}
