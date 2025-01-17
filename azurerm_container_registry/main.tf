provider "azurerm" {
  features {}
}


module "azurerm_resource_group" {
  source                          = "./modules/azurerm_resource_group"
  azurerm_resource_group_name     = var.azurerm_resource_group_name
  azurerm_resource_group_location = var.azurerm_resource_group_location
}


module "azurerm_container_registry" {
  source                                   = "./modules/azurerm_container_registry"
  azurerm_resource_group_name              = module.azurerm_resource_group.azurerm_resource_group_name
  azurerm_resource_group_location          = module.azurerm_resource_group.azurerm_resource_group_location
  azurerm_container_registry_name          = var.azurerm_container_registry_name
  azurerm_container_registry_sku           = var.azurerm_container_registry_sku
  azurerm_container_registry_admin_enabled = var.azurerm_container_registry_admin_enabled
}