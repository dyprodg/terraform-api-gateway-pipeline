resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "policy" {
  name = "lambda_policy"
  role = aws_iam_role.iam_for_lambda.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "secretsmanager:GetSecretValue"
        Resource = var.secret_arn
      },
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_lambda_function" "lambda" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  architectures    = var.lambda_architecture
  memory_size      = var.lambda_memory_size
  filename         = "dummy.zip"

  environment {
    variables = {
      SECRET_ID = var.secret_id
    }
  }

  lifecycle {
    ignore_changes = [filename]
  }

}
