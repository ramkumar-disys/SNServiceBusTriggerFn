terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  backend "azurerm" {
    resource_group_name   = "NttRG"
    storage_account_name  = "servicenowsbstorage"
    container_name        = "servicenowsbcontainer"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_servicebus_namespace" "SBNamespace" {
  name                = var.azurerm_servicebus_namespace
  location            = var.location
  resource_group_name = var.azurerm_resource_group
  sku                 = var.azurerm_sbnamespace_sku
}

resource "azurerm_servicebus_queue" "SBQueue" {
  name         = var.azurerm_servicebus_queue
  namespace_id = azurerm_servicebus_namespace.SBNamespace.id

  enable_partitioning = true
}

resource "azurerm_storage_account" "stracc" {
  name                     = var.azurerm_storage_account
  resource_group_name      = var.azurerm_resource_group
  location                 = var.location
  account_tier             = var.azurerm_stracc_tier
  account_replication_type = var.azurerm_stracc_replication_type
}

resource "azurerm_app_service_plan" "service_plan" {
  name                = var.azurerm_app_service_plan
  location            = var.location
  resource_group_name = var.azurerm_resource_group

  sku {
    tier = var.azurerm_app_service_plan_sku
    size = var.azurerm_app_service_plan_size
  }
}

resource "azurerm_function_app" "function_app" {
  name                       = var.azurerm_function_app
  location                   = var.location
  resource_group_name        = var.azurerm_resource_group
  app_service_plan_id        = azurerm_app_service_plan.service_plan.id
  storage_account_name       = azurerm_storage_account.stracc.name
  storage_account_access_key = azurerm_storage_account.stracc.primary_access_key

  app_settings = {          
    "ServicenowAzureWebJobsServiceBus"   = "Endpoint=sb://servicenow-servicebus.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=URrgi00qVMvW07dXwlxmTaBBOy1RQeSvi+ASbMgJWs8="
  }
}
