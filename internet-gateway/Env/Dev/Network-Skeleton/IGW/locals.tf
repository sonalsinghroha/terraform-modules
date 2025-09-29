locals {
  igw_tags = {
    Name      = "${var.vpc_name}-igw"
    env       = var.env_name
    owner     = var.owner_name
    ManagedBy = "Terraform"
  }
}
