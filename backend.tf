provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "eagler_api" {
  bucket = "eagler-api"
}

resource "aws_dynamodb_table" "eagler_api" {
  name           = "eagler-api"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket = "eagler-api"
    key    = "terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "eagler-api"
    encrypt = true
  }
}