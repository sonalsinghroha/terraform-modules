terraform {
  backend "s3" {
    bucket  = "dev-env-terraform-state--files"
    key     = "Network/alb/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}
