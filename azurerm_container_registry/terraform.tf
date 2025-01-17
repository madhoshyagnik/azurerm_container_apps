terraform {
  cloud {

    organization = "azurerm_madhosh"

    workspaces {
      name = "azurerm_container_registry"
    }
  }
} 