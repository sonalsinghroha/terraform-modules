terraform {
  backend "s3" {
    bucket  = "otms-dev-cloud-ops-crew"
    key     = "Network_skeleton/IGW/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}
