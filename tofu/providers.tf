terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.103.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.32.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

