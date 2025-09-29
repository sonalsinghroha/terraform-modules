# Fetch existing VPC from remote state
data "terraform_remote_state" "dev-vpc" {
  backend = "s3"
  config = {
    bucket = "otms-dev-cloud-ops-crew"
    key    = "Network_skeleton/VPC/terraform.tfstate"
    region = var.aws_region
  }
}

# Fetch Internet Gateway from remote state (for public route table)
data "terraform_remote_state" "IGW" {
  backend = "s3"
  config = {
    bucket = "otms-dev-cloud-ops-crew"
    key    = "Network_skeleton/IGW/terraform.tfstate"
    region = var.aws_region
  }
}

# Fetch NAT Gateway from remote state (for private route table)
data "terraform_remote_state" "NAT-IGW" {
  backend = "s3"
  config = {
    bucket = "otms-dev-cloud-ops-crew"
    key    = "Network_skeleton/NAT-IGW/terraform.tfstate"
    region = var.aws_region
  }
}

# Fetch subnets
data "terraform_remote_state" "Subnets" {
  backend = "s3"
  config = {
    bucket = "otms-dev-cloud-ops-crew"
    key    = "Network_skeleton/Subnets/terraform.tfstate"
    region = var.aws_region
  }
}
