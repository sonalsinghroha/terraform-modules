locals {
  nat_tags = {
    Name      = "${var.vpc_name}-nat"
    env       = var.env_name
    owner     = var.owner_name
    ManagedBy = "Terraform"
  }
}
