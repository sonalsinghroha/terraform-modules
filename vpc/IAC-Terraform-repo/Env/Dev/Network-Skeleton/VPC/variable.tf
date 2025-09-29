
#>>>>>>>>>>>>>>>>>>>VPC-VARIABLES>>>>>>>>>>>>>>>>>>>>>>>>>>>

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_enable_dns_support" {
  type    = bool
  default = true
}

variable "vpc_enable_dns_hostnames" {
  type    = bool
  default = true
}

