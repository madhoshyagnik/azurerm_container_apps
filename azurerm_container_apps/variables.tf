# Name of your resource group, it will be fetched and loaded into a variable

variable "azurerm_resource_group_name" {}

# Name of your container registry, it will not be created if it doesn't exist, we are just fetching it into our terraform configuration

variable "azurerm_container_registry_name" {}

# Below resources will be created

variable "azurerm_log_analytics_workspace_name" {}

variable "azurerm_log_analytics_workspace_sku" {}

variable "azurerm_log_analytics_workspace_retention_in_days" {}

variable "azurerm_container_app_environment_name" {}

