module "vpc" {
  source = "./module"

  cloud_provider      = module.resource-group.cloud_provider
  resource_group_name = module.resource-group.name
  region              = var.region
  name_prefix         = var.name_prefix
  address_prefix_count = 1
  address_prefixes    = ["10.0.0.0/16"]
}

resource null_resource print_enabled {
  provisioner "local-exec" {
    command = "echo -n '${module.vpc.cloud_provider}' > .cloud_provider"
  }
}
