########################################
# 4 Character Random Suffix
########################################
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
  numeric = true
}


locals {
  suffix = random_string.suffix.result

  common_tags = {
    ManagedBy = "Terraform"
    tech      = terraform.workspace
  }

  needs_network = (
    contains(var.services_to_deploy, "vm") ||
    contains(var.services_to_deploy, "aks")
    # contains(var.services_to_deploy, "bastion") ||
    # contains(var.services_to_deploy, "private_endpoint")
  )
}

########################################
# Resource Group
########################################
resource "azurerm_resource_group" "rg" {
  name     = "terraform-rg-${local.suffix}"
  location = var.location
  tags     = local.common_tags
}

########################################
# Modules 
########################################

module "databricks" {
  source   = "./modules/databricks"
  for_each = contains(var.services_to_deploy, "databricks") ? { databricks = true } : {}

  name                = "terraform-databricks-${local.suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "standard"
  tags                = local.common_tags
}

module "data_factory" {
  source   = "./modules/data_factory"
  for_each = contains(var.services_to_deploy, "data_factory") ? { data_factory = true } : {}

  name                = "terraform-adf-${local.suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = local.common_tags
}

module "synapse" {
  source   = "./modules/synapse"
  for_each = contains(var.services_to_deploy, "synapse") ? { synapse = true } : {}

  name                = "terraform-synapse-${local.suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sql_admin_login     = var.sql_admin_login
  sql_admin_password  = var.sql_admin_password
  tags                = local.common_tags
}

module "functions" {
  source   = "./modules/functions"
  for_each = contains(var.services_to_deploy, "functions") ? { functions = true } : {}

  name                = "terraform-functions-${local.suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = local.common_tags
}

module "cosmosdb" {
  source   = "./modules/cosmosdb"
  for_each = contains(var.services_to_deploy, "cosmosdb") ? { cosmosdb = true } : {}

  name                = "terraform-cosmos-${local.suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = local.common_tags
}

module "eventhub" {
  source   = "./modules/eventhub"
  for_each = contains(var.services_to_deploy, "eventhub") ? { eventhub = true } : {}

  name                = "terraform-eventhub-${local.suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = local.common_tags
}


########################################
# Network (Shared)
########################################
module "network" {
  source   = "./modules/network"
  for_each = local.needs_network ? { network = true } : {}

  vnet_name           = "terraform-vnet-${local.suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  vnet_address_space  = var.vnet_address_space
  tags                = local.common_tags  
}

########################################
# VM
########################################
module "vm" {
  source   = "./modules/vm"
  for_each = contains(var.services_to_deploy, "vm") ? { vm = true } : {}

  name                = "terraform-vm-${local.suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  vnet_name           = module.network["network"].vnet_name
  subnet_prefix       = var.vm_subnet_prefix    

  vm_size        = var.vm_size
  admin_username = var.vm_admin_username
  admin_password = var.vm_admin_password

  tags = local.common_tags  
}


########################################
# AKS
########################################
module "aks" {
  source   = "./modules/aks"
  for_each = contains(var.services_to_deploy, "aks") ? { aks = true } : {}

  name                = "terraform-aks-${local.suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  vnet_name           = module.network["network"].vnet_name
  subnet_prefix       = var.aks_subnet_prefix

  vm_size    = var.aks_vm_size
  node_count = var.aks_node_count

  tags = local.common_tags
}