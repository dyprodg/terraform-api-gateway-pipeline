#!/bin/bash

# Navigate to the lambda directory
cd lambda

# Install Node.js dependencies
npm install

# Package the Lambda function
zip -r function.zip .

# Navigate back to the Terraform directory
cd ..

# Format the Terraform code
terraform fmt

# Validate the Terraform code
terraform validate

# Apply the Terraform configuration
terraform apply -auto-approve