terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "arg" {
  name     = "TerraformHW3"
  location = "West Europe"
}

resource "azurerm_storage_account" "asa" {
  name                     = "terraformhw3storage"
  resource_group_name      = "TerraformHW3"
  account_tier             = "Standard"
  location                 = "West Europe"
  account_replication_type = "LRS"

  tags = {
    environment = "production"
  }
}
