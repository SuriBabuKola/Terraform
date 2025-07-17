terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.36.0"
    }
  }
}

provider "azurerm" {
  features {}

  client_id       = "client-id-1234"        # Replace with your Azure client ID
  client_secret   = "client-secret-1234"    # Replace with your Azure client secret
  tenant_id       = "tenant-id-1234"        # Replace with your Azure tenant ID
  subscription_id = "subscription-id-1234"  # Replace with your Azure subscription ID
}

resource "azurerm_resource_group" "my-rg" {
  name     = "test-rg"  # Desired resource group name
  location = "East US"  # Desired Azure region
}