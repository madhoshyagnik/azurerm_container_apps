resource "azurerm_log_analytics_workspace" "furniture-log-workspace" {
    name = var.azurerm_log_analytics_workspace_name
    
    resource_group_name = var.azurerm_resource_group_name
    location = var.azurerm_resource_group_location

    sku = var.azurerm_log_analytics_workspace_sku
    retention_in_days = var.azurerm_log_analytics_workspace_retention_in_days
}

# This output value will directly available in the root module using "log_analytics_workspace_id = module.azurerm_log_analytics_workspace.azurerm_log_analytics_workspace_id"

output "azurerm_log_analytics_workspace_id" {
    value = azurerm_log_analytics_workspace.furniture-log-workspace.id
}