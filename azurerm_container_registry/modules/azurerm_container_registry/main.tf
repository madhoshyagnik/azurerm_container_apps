resource "azurerm_container_registry" "furnitureRegistry" {
  name                = var.azurerm_container_registry_name
  resource_group_name = var.azurerm_resource_group_name
  sku                 = var.azurerm_container_registry_sku
  location            = var.azurerm_resource_group_location
  admin_enabled       = var.azurerm_container_registry_admin_enabled
}