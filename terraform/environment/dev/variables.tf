variable "azurerm_resource_group" {
    type = string
    default = "NttRG" 
}

variable "location" {
    type = string
    default = "East US" 
}

variable "azurerm_servicebus_namespace" {
    type = string
    default = "sb-srvcnow-dev"
}

variable "azurerm_sbnamespace_sku" {
    type = string
    default = "Standard" 
}

variable "azurerm_servicebus_queue" {
    type = string
    default = "sbq-srvcnow-messagequery" 
}

variable "azurerm_storage_account" {
    type = string
    default = "streaccsrvnow001" 
}

variable "azurerm_stracc_tier" {
    type = string
    default = "Standard" 
}

variable "azurerm_stracc_replication_type" {
    type = string
    default = "LRS" 
}

variable "azurerm_app_service_plan" {
    type = string
    default = "app-srvcnow-dev-001" 
}

variable "azurerm_app_service_plan_sku" {
    type = string
    default = "Standard" 
}

variable "azurerm_app_service_plan_size" {
    type = string
    default = "S1" 
}

variable "azurerm_function_app" {
    type = string
    default = "func-srvcnow-dev-001"
}
