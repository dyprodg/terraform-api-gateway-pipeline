provider "aws" {
  region = var.region
}

data "aws_route53_zone" "selected" {
  name = var.route53_zone_name
}

resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = "My API Gateway"
}

resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "api"
}

resource "aws_api_gateway_resource" "api_resource_verify" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.api_resource.id
  path_part   = "verify"
}

resource "aws_api_gateway_method" "api_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.api_resource_verify.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "policy" {
  name = "policy"
  role = aws_iam_role.iam_for_lambda.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "secretsmanager:GetSecretValue",
      "Resource": "${var.secret_arn}"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda" {
  filename      = var.lambda_function_filename
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.lambda_handler

  source_code_hash = filebase64sha256(var.lambda_function_filename)

  runtime = var.lambda_runtime
  architectures = var.lambda_architecture
    memory_size = var.lambda_memory_size

  environment {
    variables = {
      SECRET_ID = var.secret_id
    }
  }
}

resource "aws_api_gateway_integration" "api_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.api_resource_verify.id
  http_method = aws_api_gateway_method.api_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [aws_api_gateway_integration.api_integration]

  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "api.justanothersocialmedia.net"
  type    = "A"

  alias {
    name                   = aws_api_gateway_rest_api.api.execution_arn
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}