terraform {
  backend "s3" {
    bucket         = "cherry-infra-bucket"
    key            = "sg/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock-infra"
  }
}
