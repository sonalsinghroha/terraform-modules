variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "vpc_name" {
  description = "Name of existing VPC"
  type        = string
  default     = "dev-vpc"
}

variable "owner_name" {
  description = "Owner name"
  type        = string
  default     = "Sonal"
}

variable "env_name" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
