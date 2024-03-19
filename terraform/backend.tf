provider "aws" {
  region = var.region
}


terraform {
  backend "s3" {
    bucket         = "terraformstatebucket"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}