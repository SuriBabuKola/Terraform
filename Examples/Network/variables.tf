variable "resource_group_name" {
  default     = "terraform-rg"
  description = "Resource Group Name"
}

variable "resource_group_location" {
  default     = "West US"
  description = "Resource Group Location"
}

variable "virtual_network_name" {
  default     = "terraform-vnet"
  description = "Virtual Network Name"
}

variable "subnet01_name" {
  default     = "terraform-sub01"
  description = "Subnet01 Name"
}

variable "subnet02_name" {
  default     = "terraform-sub02"
  description = "Subnet02 Name"
}