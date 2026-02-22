############################################
# Event Hub Namespace
############################################
resource "azurerm_eventhub_namespace" "ns" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = 1

  tags = var.tags
}

############################################
# Event Hub
############################################
resource "azurerm_eventhub" "hub" {
  name                = "${var.name}-hub"
  namespace_name      = azurerm_eventhub_namespace.ns.name
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
}