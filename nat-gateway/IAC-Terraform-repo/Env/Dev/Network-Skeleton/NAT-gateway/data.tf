data "terraform_remote_state" "Subnets" {
  backend = "s3"

  config = {
    bucket = "otms-dev-cloud-ops-crew"
    key    = "Network_skeleton/Subnets/terraform.tfstate"
    region = "us-east-2"
  }
}

data "aws_vpc" "dev" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Filter dev-public-subnet-2 ID from remote state outputs
data "aws_subnet" "nat_subnet" {
  id = data.terraform_remote_state.Subnets.outputs.subnet_ids["dev-public-subnet-2"]
}
