variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "vpc_name" {
  description = "name of existing vpc"
  type        = string
  default     = "dev-vpc"
}

variable "subnets" {
  description = "value"
  type = list(object({
    name       = string
    cidr       = string
    avail_zone = string
  }))
  default = [
    { name = "dev-public-subnet-1", cidr = "10.0.1.0/24", avail_zone = "us-east-2a" },
    { name = "dev-frontend-subnet", cidr = "10.0.10.0/24", avail_zone = "us-east-2b" },
    { name = "dev-application-subnet", cidr = "10.0.20.0/24", avail_zone = "us-east-2b" },
    { name = "dev-database-subnet", cidr = "10.0.30.0/24", avail_zone = "us-east-2b" },
    { name = "dev-public-subnet-2", cidr = "10.0.2.0/24", avail_zone = "us-east-2b" }
  ]
}

variable "owner_name" {
  default     = "sneha"
  description = "Owner name"
}

variable "env_name" {
  default     = "dev"
  description = "Environment"
}
