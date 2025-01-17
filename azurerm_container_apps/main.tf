provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "furniture_rg" {
  name = var.azurerm_resource_group_name
}

data "azurerm_container_registry" "furnitureRegistry" {
  name                = var.azurerm_container_registry_name
  resource_group_name = data.azurerm_resource_group.furniture_rg.name
}

module "azurerm_log_analytics_workspace" {
  source                                            = "./modules/azurerm_log_analytics_workspace"
  azurerm_resource_group_name                       = data.azurerm_resource_group.furniture_rg.name
  azurerm_resource_group_location                   = data.azurerm_resource_group.furniture_rg.location
  azurerm_log_analytics_workspace_name              = var.azurerm_log_analytics_workspace_name
  azurerm_log_analytics_workspace_sku               = var.azurerm_log_analytics_workspace_sku
  azurerm_log_analytics_workspace_retention_in_days = var.azurerm_log_analytics_workspace_retention_in_days
}

module "azurerm_container_app_environment" {
  source = "./modules/azurerm_container_app_environment"
  azurerm_container_app_environment_name = var.azurerm_container_app_environment_name
  azurerm_resource_group_name = data.azurerm_resource_group.furniture_rg.name
  azurerm_resource_group_location = data.azurerm_resource_group.furniture_rg.location
  azurerm_log_analytics_workspace_id = module.azurerm_log_analytics_workspace.azurerm_log_analytics_workspace_id
}

resource "azurerm_container_app" "furniture-container-app" {
  name                         = "furniture-container-app"
  container_app_environment_id = module.azurerm_container_app_environment.azurerm_container_app_environment_id
  resource_group_name          = data.azurerm_resource_group.furniture_rg.name
  revision_mode                = "Single"

  template {
    container {
      name   = "furniture-container"
      image  = "furnitureregistry.azurecr.io/furnitureapp:latest"
      cpu    = 0.5
      memory = "1.0Gi"
    }

    max_replicas = 6
    min_replicas = 1
    http_scale_rule {
      name                = "furniture-http-scale-group"
      concurrent_requests = 20
    }
  }

  ingress {
    transport                  = "auto"
    external_enabled           = true
    allow_insecure_connections = true

    target_port = 80

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }

  }

  registry {
    server               = data.azurerm_container_registry.furnitureRegistry.login_server
    username             = data.azurerm_container_registry.furnitureRegistry.admin_username
    password_secret_name = "registry-credentials"
  }

  secret {
    name  = "registry-credentials"
    value = data.azurerm_container_registry.furnitureRegistry.admin_password
  }
}


output "application_url" {
  value = azurerm_container_app.furniture-container-app.latest_revision_fqdn

}