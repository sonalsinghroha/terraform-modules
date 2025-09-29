data "terraform_remote_state" "dev-vpc" {
  backend = "s3"

  config = {
    bucket = "otms-dev-cloud-ops-crew"
    key    = "Network_skeleton/VPC/terraform.tfstate"
    region = "us-east-2"
  }
}
