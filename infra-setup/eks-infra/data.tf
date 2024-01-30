data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "cherry-infra-bucket"
    key    = "network/terraform.tfstate"
    region = "ap-south-1"

  }
}
