resource "azurerm_iothub" "default" {
    name                = "test"
    resource_group_name = "${azurerm_resource_group.default.name}"
    location            = "${azurerm_resource_group.default.location}"

    sku {
        name     = "S1"
        tier     = "Standard"
        capacity = "1"
    }
}