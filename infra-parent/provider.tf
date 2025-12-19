terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.50.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "d6a5ead9-73a7-4b4e-a9e0-23f34a175cc8"
}