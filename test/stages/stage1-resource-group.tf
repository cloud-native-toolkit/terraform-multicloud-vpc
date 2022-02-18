module "resource-group" {
  source = "github.com/cloud-native-toolkit/terraform-multicloud-resource-group"

  resource_group_name = var.resource_group_name
  region              = var.region
  cloud_provider      = var.cloud_provider
}
