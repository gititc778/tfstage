terraform {
  backend "azurerm" {
    resource_group_name  = "tfproject"
    storage_account_name = "projdbktf9417"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
