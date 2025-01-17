# Values for these variables be set when we define a variables.tf in root module and add these values there or in a terraform.tfvars 

variable "azurerm_log_analytics_workspace_name" {}

variable "azurerm_log_analytics_workspace_sku" {}

variable "azurerm_log_analytics_workspace_retention_in_days" {}



# Pass these variables from the root module by accessing either resource, data source or module value

variable "azurerm_resource_group_name" {}

variable "azurerm_resource_group_location" {}


