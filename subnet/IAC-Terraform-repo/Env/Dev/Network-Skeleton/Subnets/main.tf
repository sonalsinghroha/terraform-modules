resource "aws_subnet" "subnets" {
  count = length(var.subnets)

  vpc_id            = data.aws_vpc.dev.id
  cidr_block        = var.subnets[count.index].cidr
  availability_zone = var.subnets[count.index].avail_zone

  tags = local.subnet_tags[count.index]
}
