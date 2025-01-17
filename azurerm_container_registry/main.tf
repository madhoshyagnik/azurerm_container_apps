provider "azurerm" {
  features {}
}


module "azurerm_resource_group" {
  source                          = "./modules/azurerm_resource_group"
  azurerm_resource_group_name     = "furniture_rg"
  azurerm_resource_group_location = "Central India"
}


module "azurerm_container_registry" {
  source                                   = "./modules/azurerm_container_registry"
  azurerm_resource_group_name              = module.azurerm_resource_group.azurerm_resource_group_name
  azurerm_resource_group_location          = module.azurerm_resource_group.azurerm_resource_group_location
  azurerm_container_registry_name          = "furnitureRegistry"
  azurerm_container_registry_sku           = "Basic"
  azurerm_container_registry_admin_enabled = true

}