data "aws_vpc" "dev" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.dev.id
  tags = local.igw_tags
}
