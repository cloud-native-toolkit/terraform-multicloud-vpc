
locals {
  internal_cidr = var.address_prefix_count > 0 ? var.address_prefixes[0] : "10.0.0.0/16"
  vpc = var.cloud_provider == "ibm" ? module.ibm-vpc : var.cloud_provider == "aws" ? module.aws-vpc : module.azure-vpc
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

  enabled              = var.cloud_provider == "ibm"
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

  enabled              = var.cloud_provider == "aws"
  provision            = var.provision
  resource_group_name  = var.resource_group_name
  name                 = var.name
  prefix_name          = var.name_prefix
  internal_cidr        = local.internal_cidr
  external_cidr        = var.external_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

module azure-vpc {
  source = "github.com/cloud-native-toolkit/terraform-azure-vpc"

  enabled              = var.cloud_provider == "azure"
  provision            = var.provision
  resource_group_name  = var.resource_group_name
  name                 = var.name
  prefix_name          = var.name_prefix
  address_prefix_count = var.address_prefix_count
  address_prefixes     = var.address_prefixes
}
