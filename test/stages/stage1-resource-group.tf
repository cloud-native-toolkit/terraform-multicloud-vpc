module "resource-group" {
  source = "./module"

  resource_group_name = var.resource_group_name
  region              = var.region
  cloud_provider      = var.cloud_provider
}
