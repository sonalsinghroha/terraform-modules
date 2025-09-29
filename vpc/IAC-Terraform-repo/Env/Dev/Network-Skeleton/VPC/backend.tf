terraform {
  backend "s3" {
    bucket         = "otms-dev-cloud-ops-crew"
      key            = "Network_skeleton/VPC/terraform.tfstate"  
    region         = "us-east-2"
   # dynamodb_table = "cloud-ops"
    encrypt        = true
  }
}
