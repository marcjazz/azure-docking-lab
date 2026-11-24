terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name  = "rg-tfstate-mgmt"
    storage_account_name = "sttfstate1327532040"
    container_name       = "tfstate"
    key                  = "docking-lab.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-docking-lab-dev"
  location = "francecentral"
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  entity_name         = "docking-lab"
}

resource "azurerm_storage_account" "app_sa" {
  name                     = "stapp${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}