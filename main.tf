locals {
  name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}

resource "random_password" "sql_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

data "azurerm_resource_group" "target" {
  name = "tfproject"
}

module "databricks" {
  source = "./modules/databricks"

  name                = "${local.name_prefix}-dbx-${random_string.unique.result}"
  resource_group_name = data.azurerm_resource_group.target.name
  location            = var.location
  sku                 = "standard"
  tags                = local.common_tags
}

module "data_factory" {
  source = "./modules/data_factory"

  name                = "${local.name_prefix}-adf-${random_string.unique.result}"
  resource_group_name = data.azurerm_resource_group.target.name
  location            = var.location
  tags                = local.common_tags
}

module "synapse" {
  source = "./modules/synapse"

  name                = "${local.name_prefix}-syn-${random_string.unique.result}"
  resource_group_name = data.azurerm_resource_group.target.name
  location            = var.location
  sql_admin_login     = var.sql_admin_login
  sql_admin_password  = random_password.sql_password.result
  tags                = local.common_tags
}

module "functions" {
  source = "./modules/functions"

  name                = "${local.name_prefix}-func-${random_string.unique.result}"
  resource_group_name = data.azurerm_resource_group.target.name
  location            = var.location
  tags                = local.common_tags
}

module "cosmosdb" {
  source = "./modules/cosmosdb"

  name                = "cosmos-${random_string.unique.result}"
  resource_group_name = data.azurerm_resource_group.target.name
  location            = var.location
  tags                = local.common_tags
}

module "eventhub" {
  source = "./modules/eventhub"

  name                = "${local.name_prefix}-evh-${random_string.unique.result}"
  resource_group_name = data.azurerm_resource_group.target.name
  location            = var.location
  tags                = local.common_tags
}
