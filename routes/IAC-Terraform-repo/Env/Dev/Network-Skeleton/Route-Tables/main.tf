# Create Public Route Table
resource "aws_route_table" "public" {
  vpc_id = data.terraform_remote_state.dev-vpc.outputs["vpc-id"]

  tags = local.public_rt_tags
}

# Attach Public Route Table to Public Subnets
resource "aws_route_table_association" "public_assoc" {
  for_each = { for name, id in data.terraform_remote_state.Subnets.outputs.subnet_ids : name => id if name == "dev-public-subnet-1" || name == "dev-public-subnet-2" }

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

# Add route to Internet Gateway
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = data.terraform_remote_state.IGW.outputs.internet_gateway["dev-vpc-igw"]
}

# Create Private Route Table
resource "aws_route_table" "private" {
  vpc_id = data.terraform_remote_state.dev-vpc.outputs["vpc-id"]

  tags = local.private_rt_tags
}

# Attach Private Route Table to Private Subnets
resource "aws_route_table_association" "private_assoc" {
  for_each = { for name, id in data.terraform_remote_state.Subnets.outputs.subnet_ids : name => id if name != "dev-public-subnet-1" && name != "dev-public-subnet-2" }

  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}

# Add route to NAT Gateway
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = data.terraform_remote_state.NAT-IGW.outputs.nat_gateway_id
}
