terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.3.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.98.0"
    }
  }
}

provider "azurerm" {
  features {}
}