output "subnet_ids" {
  value = {
    for subnet in aws_subnet.subnets :
    subnet.tags.Name => subnet.id
  }
}
