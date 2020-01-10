variable "name" {
    default = "openhack-iot"
}

variable "environment" {
    default = "dev"
}

variable "location" {
    default = "Central US"
}

variable "iot_hub_sku" {
    default = "S1"
}

variable "use_ssh" {
    default = false
}

variable "username" {
    default = "iotohuser"
}

variable "password" {
    default = "Password.1!"
}

variable "ssh_key" {
    default = ""
}