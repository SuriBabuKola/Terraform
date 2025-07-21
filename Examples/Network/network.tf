resource "azurerm_resource_group" "terraform-rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "terraform-vnet" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.terraform-rg.location
  resource_group_name = azurerm_resource_group.terraform-rg.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name             = var.subnet01_name
    address_prefixes = ["10.0.1.0/24"]
  }
}

resource "azurerm_subnet" "terraform-subnet" {
  name                 = var.subnet02_name
  resource_group_name  = azurerm_resource_group.terraform-rg.name
  virtual_network_name = azurerm_virtual_network.terraform-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}