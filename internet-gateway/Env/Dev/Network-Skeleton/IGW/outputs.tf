output "internet_gateway" {
  description = "Internet Gateway details with Name as key and ID as value"
  value = {
    (aws_internet_gateway.igw.tags["Name"]) = aws_internet_gateway.igw.id
  }
}
