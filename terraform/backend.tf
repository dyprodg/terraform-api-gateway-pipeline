provider "aws" {
  region = var.region
}


terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-dyprodg-12334"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-api-state"
    encrypt        = true
  }
}