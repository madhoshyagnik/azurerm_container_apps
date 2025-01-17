resource "azurerm_container_app_environment" "furniture-app-environment" {
  name                       = var.azurerm_container_app_environment_name
  location                   = var.azurerm_resource_group_location
  resource_group_name        = var.azurerm_resource_group_name
  log_analytics_workspace_id = var.azurerm_log_analytics_workspace_id
}

# The id of the above resource will be needed to launch a container app cluster, to use this in root module, the variable name doesn't need to be in variables.tf

output "azurerm_container_app_environment_id" {
    value = azurerm_container_app_environment.furniture-app-environment.id
}