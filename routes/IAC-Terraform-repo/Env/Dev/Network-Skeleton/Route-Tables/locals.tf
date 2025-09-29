locals {
  # Public route table tags
  public_rt_tags = {
    Name      = "${var.vpc_name}-public-rt"
    env       = var.env_name
    owner     = var.owner_name
    ManagedBy = "Terraform"
  }

  # Private route table tags
  private_rt_tags = {
    Name      = "${var.vpc_name}-private-rt"
    env       = var.env_name
    owner     = var.owner_name
    ManagedBy = "Terraform"
  }

  # Subnets mapping
  public_subnets  = [for s in data.terraform_remote_state.Subnets.outputs.subnet_ids : s if s == "dev-public-subnet-1" || s == "dev-public-subnet-2"]
  private_subnets = [for s in data.terraform_remote_state.Subnets.outputs.subnet_ids : s if s != "dev-public-subnet-1" && s != "dev-public-subnet-2"]
}
