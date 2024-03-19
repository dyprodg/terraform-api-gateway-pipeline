variable "region" {
  description = "The AWS region"
  default     = "eu-central-1"
}

variable "route53_zone_name" {
  description = "The name of the Route53 zone"
  default     = "your route53 zone name here"
}

variable "api_name" {
  description = "The name of the API Gateway"
  default     = "MyAPI"
}

variable "lambda_function_filename" {
  description = "The filename of the Lambda function deployment package"
  default     = "lambda_function_payload.zip"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  default     = "lambda_function_name"
}

variable "lambda_handler" {
  description = "The handler of the Lambda function"
  default     = "index.handler"
}

variable "lambda_runtime" {
  description = "The runtime of the Lambda function"
  default     = "nodejs18.x"
}

variable "lambda_architecture" {
  description = "The architecture of the Lambda function"
  default     = "arm64"
}

variable "lambda_memory_size" {
  description = "The memory size of the Lambda function"
  default     = 128
}

variable "secret_id" {
  description = "The ID of the secret in AWS Secrets Manager"
  default     = "your secret id here"
}

variable "secret_arn" {
  description = "The ARN of the secret in AWS Secrets Manager"
  default     = "your secret arn here"
}
