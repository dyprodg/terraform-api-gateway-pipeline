variable "region" {
  description = "The AWS region"
  default     = "eu-central-1"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "eagler-api"
}

variable "state_bucket" {
  description = "The name of the S3 bucket for the Terraform state"
  default     = "eagler-api"
}

variable "route53_zone_name" {
  description = "The name of the Route53 zone"
  default     = "justanothersocialmedia.net"
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
  default     = "lambda/index.handler"
}

variable "lambda_runtime" {
  description = "The runtime of the Lambda function"
  default     = "nodejs18.x"
}

variable "lambda_architecture" {
  description = "The architecture of the Lambda function"
  default     = ["x86_64"]
}

variable "lambda_memory_size" {
  description = "The memory size of the Lambda function"
  default     = 128
}

variable "secret_id" {
  description = "The ID of the secret in AWS Secrets Manager"
  default     = "eagler-secrets-A8629Z"
}

variable "secret_arn" {
  description = "The ARN of the secret in AWS Secrets Manager"
  default     = "arn:aws:secretsmanager:eu-central-1:283919506801:secret:eagler-secrets-A8629Z"
}

variable "github_connection" {
  description = "The connection to GitHub"
  default     = "arn:aws:codestar-connections:eu-central-1:283919506801:connection/ad54301b-21a5-4655-913d-b17e43a04edd"
}

variable "github_repository" {
  description = "The GitHub repository"
  default     = "dyprodg/terraform-api-gateway-pipeline"
}

variable "github_branch" {
  description = "The GitHub branch"
  default     = "main"
}

variable "build_project_name" {
  description = "The name of the CodeBuild project"
  default     = "my-build-project"
}


variable "s3_artifact_bucket_name" {
  description = "The name of the S3 bucket for the CodePipeline artifact"
  default     = "eagler-api-lambda-artifact"
}

variable "codebuild_compute_type" {
  description = "The compute type of the CodeBuild project"
  default     = "BUILD_GENERAL1_SMALL"
  
}

variable "codebuild_image" {
  description = "The image of the CodeBuild project"
  default     = "aws/codebuild/standard:7.0"
  
}

variable "codebuild_env_type" {
    description = "The environment type of the CodeBuild project"
    default     = "LINUX_CONTAINER"
}

variable "build_log_group_name" {
  description = "The name of the CloudWatch Logs group"
  default     = "eagler-api-build-logs" 
}

variable "build_log_stream_name" {
  description = "The name of the CloudWatch Logs stream"
  default     = "eagler-api-build-stream"
}

variable "codedeploy_application_name" {
  description = "The name of the CodeDeploy application"
  default     = "eagler-api"
}

variable "codedeploy_deployment_group_name" {
  description = "The name of the CodeDeploy deployment group"
  default     = "eagler-api-deployment-group"
}