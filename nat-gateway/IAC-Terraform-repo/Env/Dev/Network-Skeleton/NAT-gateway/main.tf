# Allocate Elastic IP
resource "aws_eip" "nat" {

  tags = merge(local.nat_tags, { Resource = "EIP" })
}

# Create NAT Gateway in dev-public-subnet-2
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = data.aws_subnet.nat_subnet.id

  tags = local.nat_tags
}
