provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "furniture_rg" {
    name = "furniture_rg"
}

data "azurerm_container_registry" "furnitureRegistry" {
    name = "furnitureRegistry"
    resource_group_name = data.azurerm_resource_group.furniture_rg.name
}



resource "azurerm_log_analytics_workspace" "furniture-log-workspace" {
    name = "furniture-log-workspace"
    resource_group_name = data.azurerm_resource_group.furniture_rg.name
    location = data.azurerm_resource_group.furniture_rg.location

    sku = "PerGB2018"
    retention_in_days = 30

}

resource "azurerm_container_app_environment" "furniture-app-environment" {
    name = "furniture-app-environment"
    location = data.azurerm_resource_group.furniture_rg.location
    resource_group_name = data.azurerm_resource_group.furniture_rg.name
    log_analytics_workspace_id = azurerm_log_analytics_workspace.furniture-log-workspace.id
}

resource "azurerm_container_app" "furniture-container-app" {
    name = "furniture-container-app"
    container_app_environment_id = azurerm_container_app_environment.furniture-app-environment.id
    resource_group_name = data.azurerm_resource_group.furniture_rg.name
    revision_mode = "Single"
    
    template {
        container {
          name = "furniture-container"
          image = "furnitureregistry.azurecr.io/furnitureapp:latest"
          cpu = 0.5
          memory = "1.0Gi"
        }

        max_replicas = 6
        min_replicas = 1
        http_scale_rule {
          name = "furniture-http-scale-group"
          concurrent_requests = 20
        }
    }

    ingress {
      transport = "auto"
      external_enabled = true
      allow_insecure_connections = true

      target_port = 80

      traffic_weight {
        percentage = 100
        latest_revision = true
      }
    
    }

    registry {
      server = "${data.azurerm_container_registry.furnitureRegistry.login_server}"
      username = "${data.azurerm_container_registry.furnitureRegistry.admin_username}"
      password_secret_name = "registry-credentials"
    }

    secret {
      name = "registry-credentials"
      value = "${data.azurerm_container_registry.furnitureRegistry.admin_password}"
    }
}


output "application_url" {
    value = azurerm_container_app.furniture-container-app.latest_revision_fqdn
  
}