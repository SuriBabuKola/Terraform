resource "azurerm_resource_group" "terraform-rg" {
  name     = "terraform-rg"
  location = "West US"
}

resource "azurerm_virtual_network" "terraform-vnet" {
  name                = "terraform-vnet"
  location            = azurerm_resource_group.terraform-rg.location
  resource_group_name = azurerm_resource_group.terraform-rg.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name             = "terraform-sub01"
    address_prefixes = ["10.0.1.0/24"]
  }
}

resource "azurerm_subnet" "terraform-subnet" {
  name                 = "terraform-sub02"
  resource_group_name  = azurerm_resource_group.terraform-rg.name
  virtual_network_name = azurerm_virtual_network.terraform-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}