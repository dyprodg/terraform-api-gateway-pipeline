provider "aws" {
  region = "eu-central-1"
}


terraform {
  backend "s3" {
    bucket         = "eagler-api"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "eagler-api"
    encrypt        = true
  }
}