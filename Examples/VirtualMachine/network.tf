resource "azurerm_resource_group" "terraform_rg" {
  name     = var.azurerm_resource_group_name
  location = var.azurerm_resource_group_location
}

resource "azurerm_virtual_network" "terraform_vnet" {
  name                = var.azurerm_vnet_name
  location            = azurerm_resource_group.terraform_rg.location
  resource_group_name = azurerm_resource_group.terraform_rg.name
  address_space       = var.azurerm_vnet_cidr

  subnet {
    name             = var.azurerm_subnet01_name
    address_prefixes = var.azurerm_subnet01_cidr
  }
}

resource "azurerm_subnet" "terraform_subnet" {
  name                 = var.azurerm_subnet02_name
  resource_group_name  = azurerm_resource_group.terraform_rg.name
  virtual_network_name = azurerm_virtual_network.terraform_vnet.name
  address_prefixes     = var.azurerm_subnet02_cidr
}