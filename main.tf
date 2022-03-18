terraform {
  backend "azurerm" {
    resource_group_name  = "devopslearning"
    storage_account_name = "tfstatesfab"
    container_name       = "tfstates"
    key                  = "terraformgithubexample.tfstate"
  }
}
 
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}
 
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
      Environment = "Dev"
      Team = "DevOps"
      }
}
# Create a virtual network
resource "azurerm_virtual_network" "spokevnet" {
  name                = "SpokeVnet"
  address_space       = ["10.1.0.0/16"]
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg.name
}