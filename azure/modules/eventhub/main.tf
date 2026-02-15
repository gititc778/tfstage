resource "azurerm_eventhub_namespace" "evh_ns" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = 1
  tags                = var.tags
}

resource "azurerm_eventhub" "evh" {
  name                = "evh-${var.name}"
  namespace_name      = azurerm_eventhub_namespace.evh_ns.name
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
}
