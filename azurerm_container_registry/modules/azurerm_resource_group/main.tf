resource "azurerm_resource_group" "furniture_rg" {
  name     = var.azurerm_resource_group_name
  location = var.azurerm_resource_group_location
}

output "azurerm_resource_group_name" {
    value = azurerm_resource_group.furniture_rg.name
}

output "azurerm_resource_group_location" {
    value = azurerm_resource_group.furniture_rg.location
}

output "azurerm_resource_group_id" {
    value = azurerm_resource_group.furniture_rg.id
}