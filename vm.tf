# Hack to get a conditional ssh support
locals {
    use_ssh = var.use_ssh == "true" ? [1] : []
}

# Public IP for our Factory Monitor VM
resource "azurerm_public_ip" "factorymonitor_vm" {
  name                = "${var.name}-factorymonitor-vm-pip"
  location            = "${azurerm_resource_group.default.location}"
  resource_group_name = "${azurerm_resource_group.default.name}"
  allocation_method   = "Dynamic"
}

# Nic for our Factory Monitor VM
resource "azurerm_network_interface" "factorymonitor_vm" {
    name                = "${var.name}-factorymonitor-vm-nic"
    location            = "${azurerm_resource_group.default.location}"
    resource_group_name = "${azurerm_resource_group.default.name}"

    ip_configuration {
        name                          = "testconfiguration1"
        public_ip_address_id          = "${azurerm_public_ip.factorymonitor_vm.id}"
        private_ip_address_allocation = "dynamic"
    }
}

# The factory monitor virtual machine
resource "azurerm_virtual_machine" "factorymonitor" {
    name                  = "${var.name}-factorymonitor-vm"
    location              = "${azurerm_resource_group.default.location}"
    resource_group_name   = "${azurerm_resource_group.default.name}"
    network_interface_ids = ["${azurerm_network_interface.factorymonitor_vm.id}"]
    vm_size               = "Standard_DS1_v2"

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    storage_os_disk {
        name              = "osdisk1"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    os_profile {
        computer_name  = "factorymonitor"
        admin_username = "${var.username}"
        admin_password = "${var.password}"
    }

    dynamic "os_profile_linux_config" {
        for_each = "${local.use_ssh}"
        content {
            disable_password_authentication = true
            ssh_keys {
                key_data = "${var.ssh_key}"
                path = "/home/${var.username}/.ssh/authorized_keys"
            }
        }
    }
}