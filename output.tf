output "username" {
  value = "${var.username}"
}

output "password" {
  value = "${var.password}"
}

output "factorymonitor_ip" {
  value = "${azurerm_public_ip.factorymonitor_vm.ip_address}"
}

output "iothub_name" {
  value = "${azurerm_iothub.default.name}"
}

output "iothub_hostname" {
  value = "${azurerm_iothub.default.hostname}"
}

output "resource_group_name" {
  value = "${azurerm_resource_group.default.name}"
}

output "dps_name" {
  value = "${azurerm_iothub_dps.default.name}"
}