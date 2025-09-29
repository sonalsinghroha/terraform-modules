data "terraform_remote_state" "dev_vpc" {
  backend = "s3"

  config = {
    bucket = "dev-env-terraform-state--files"
    key    = "Network/VPC/terraform.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "subnets" {
  backend = "s3"

  config = {
    bucket = "dev-env-terraform-state--files"
    key    = "Network/Subnets/terraform.tfstate"
    region = "us-east-2"
  }
}