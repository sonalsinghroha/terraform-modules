variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "vpc_name" {
  description = "Name of the existing VPC"
  type        = string
  default     = "dev-vpc"
}

variable "owner_name" {
  description = "Owner Name"
  type        = string
  default     = "Divya"
}

variable "env_name" {
  description = "Environment Name"
  type        = string
  default     = "dev"
}
