variable "azurerm_resource_group_name" {
  default = "terraform-rg"
}

variable "azurerm_resource_group_location" {
  default = "East US"
}

variable "azurerm_vnet_name" {
  default = "terraform-vnet"
}

variable "azurerm_vnet_cidr" {
  default = ["10.0.0.0/16"]
}

variable "azurerm_subnet01_name" {
  default = "terraform-sub01"
}

variable "azurerm_subnet01_cidr" {
  default = ["10.0.1.0/24"]
}

variable "azurerm_subnet02_name" {
  default = "terraform-sub02"
}

variable "azurerm_subnet02_cidr" {
  default = ["10.0.2.0/24"]
}