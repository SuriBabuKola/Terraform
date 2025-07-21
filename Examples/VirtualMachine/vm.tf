resource "azurerm_public_ip" "terraform_vm_public_ip" {
  name                = var.azurerm_public_ip_name
  resource_group_name = azurerm_resource_group.terraform_rg.name
  location            = azurerm_resource_group.terraform_rg.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "terraform_nic" {
  name                = var.azurerm_nic_name
  location            = azurerm_resource_group.terraform_rg.location
  resource_group_name = azurerm_resource_group.terraform_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.terraform_vm_public_ip.id
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = var.azurerm_vm_name
  location              = azurerm_resource_group.terraform_rg.location
  resource_group_name   = azurerm_resource_group.terraform_rg.name
  network_interface_ids = [azurerm_network_interface.terraform_nic.id]
  vm_size               = "Standard_B1s"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "nagas"
    admin_password = "suresh@123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}