locals {
  subnet_tags = [for subnet in var.subnets : {
    Name  = subnet.name
    env   = var.env_name
    owner = var.owner_name
  }]

data "aws_vpc" "dev" {
  filter {
    name   = "tag:Name"
    values = ["dev-vpc"]
  }
}
}
