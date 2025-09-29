#>>>>>>>>>>>>>>>>>>>VPC-CREATION-CODE>>>>>>>>>>>>>>>>>>>>>>>>>>>

resource "aws_vpc" "dev-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags                 = local.vpc_tags
}
