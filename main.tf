
locals {
  internal_cidr = var.address_prefix_count > 0 ? var.address_prefixes[0] : "10.0.0.0/16"
  vpc = try(var.cloud_provider == "ibm" ? module.ibm-vpc[0] : var.cloud_provider == "aws" ? module.aws-vpc[0] : var.cloud_provider == "azure" ? module.azure-vpc[0] : tomap(false), {})
  vpc_name = lookup(local.vpc, "name", "")
  vpc_id = lookup(local.vpc, "id", "")
  acl_id = lookup(local.vpc, "acl_id", "")
  crn = lookup(local.vpc, "crn", "")
  count = lookup(local.vpc, "count", 0)
  names = lookup(local.vpc, "names", [])
  ids = lookup(local.vpc, "ids", [])
  base_security_group = lookup(local.vpc, "base_security_group", "")
  addresses = lookup(local.vpc, "addresses", [])
}

module ibm-vpc {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc"
  count  = var.cloud_provider == "ibm" ? 1 : 0

  provision            = var.provision
  resource_group_name  = var.resource_group_name
  region               = var.region
  name                 = var.name
  name_prefix          = var.name_prefix
  address_prefix_count = var.address_prefix_count
  address_prefixes     = var.address_prefixes
  base_security_group_name = var.base_security_group_name
  internal_cidr        = var.internal_cidr
}

module aws-vpc {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc"
  count  = var.cloud_provider == "aws" ? 1 : 0

  provision            = var.provision
  resource_group_name  = var.resource_group_name
  name                 = var.name
  name_prefix          = var.name_prefix
  internal_cidr        = local.internal_cidr
  external_cidr        = var.external_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

module azure-vpc {
  source = "github.com/cloud-native-toolkit/terraform-azure-vpc"
  count  = var.cloud_provider == "azure" ? 1 : 0

  provision            = var.provision
  resource_group_name  = var.resource_group_name
  name                 = var.name
  name_prefix          = var.name_prefix
  region               = var.region
  address_prefix_count = var.address_prefix_count
  address_prefixes     = var.address_prefixes
}
