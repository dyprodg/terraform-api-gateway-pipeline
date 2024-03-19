#!/bin/bash

# Navigate to the lambda directory
cd lambda

# Install Node.js dependencies
npm install

# Navigate back to the Terraform directory
cd ..

# Package the Lambda function
zip -r lambda_function_payload.zip lambda/*

# Format the Terraform code
terraform fmt

# Validate the Terraform code
terraform validate

# Apply the Terraform configuration
terraform apply -auto-approve