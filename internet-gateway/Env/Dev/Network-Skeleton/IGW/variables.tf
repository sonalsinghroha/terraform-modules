variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "vpc_name" {
  description = "Name of the existing VPC where IGW will be created"
  type        = string
  default     = "dev-vpc"
}

variable "igw_name" {
  description = "Name for the Internet Gateway"
  type        = string
  default     = "dev-vpc-igw"
}

variable "owner_name" {
  description = "Owner name for tagging"
  type        = string
  default     = "Sonal"
}

variable "env_name" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}
