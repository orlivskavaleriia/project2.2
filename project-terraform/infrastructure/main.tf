provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket         = "glovo-terraform-backend"
    key            = "terraform/state/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    #dynamodb_table = "terraform-lock-table"
  }
}