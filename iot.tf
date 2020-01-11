resource "azurerm_iothub" "default" {
    name                = "${var.name}-${var.environment}-iot"
    resource_group_name = "${azurerm_resource_group.default.name}"
    location            = "${azurerm_resource_group.default.location}"

    sku {
        name     = "S1"
        tier     = "Standard"
        capacity = "1"
    }
}

resource "azurerm_iothub_dps" "default" {
  name                = "${var.name}-${var.environment}-iotdps"
  resource_group_name = "${azurerm_resource_group.default.name}"
  location            = "${var.dps_location}"

  sku {
    name     = "S1"
    tier     = "Standard"
    capacity = "1"
  }

  linked_hub {
      connection_string = "HostName=${azurerm_iothub.default.hostname};SharedAccessKeyName=${azurerm_iothub.default.shared_access_policy[0].key_name};SharedAccessKey=${azurerm_iothub.default.shared_access_policy[0].primary_key}"
      location = "${azurerm_iothub.default.location}"
  }
}

