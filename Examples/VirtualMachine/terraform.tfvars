azurerm_resource_group_name     = "dev-rg"
azurerm_resource_group_location = "West US"

azurerm_vnet_name     = "dev-vnet"
azurerm_vnet_cidr     = ["192.168.0.0/16"]
azurerm_subnet01_name = "dev-sub01"
azurerm_subnet01_cidr = ["192.168.1.0/24"]
azurerm_subnet02_name = "dev-sub02"
azurerm_subnet02_cidr = ["192.168.2.0/24"]

azurerm_public_ip_name = "dev-vm-public-ip"
azurerm_nic_name       = "dev-nic"
azurerm_vm_name        = "dev-vm"