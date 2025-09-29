aws_region = "us-east-2"

vpc_name = "dev-vpc"

subnets = [
  { name = "dev-public-subnet-1", cidr = "10.0.1.0/24", avail_zone = "us-east-2a" },
  { name = "dev-frontend-subnet", cidr = "10.0.10.0/24", avail_zone = "us-east-2b" },
  { name = "dev-application-subnet", cidr = "10.0.20.0/24", avail_zone = "us-east-2b" },
  { name = "dev-database-subnet", cidr = "10.0.30.0/24", avail_zone = "us-east-2b" },
  { name = "dev-public-subnet-2", cidr = "10.0.2.0/24", avail_zone = "us-east-2b" }
]

owner_name = "Sneha"

env_name = "dev"
