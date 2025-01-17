# Pass these variables from the root module by accessing either resource, data source or module value

variable "azurerm_resource_group_name" {}

variable "azurerm_resource_group_location" {}


# Value for this variables will be received from azurerm_log_analytics_workspace module

variable "azurerm_log_analytics_workspace_id" {}

# Will be set using defined value

variable "azurerm_container_app_environment_name" {}
