provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

provider "aws" {
  region     = var.cloud_provider == "aws" ? var.region : ""
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "ibm" {
  region           = var.cloud_provider == "ibm" ? var.region : ""
  ibmcloud_api_key = var.ibmcloud_api_key
}
