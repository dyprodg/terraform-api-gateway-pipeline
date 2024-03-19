#!/bin/bash

# Generate a random name for the S3 bucket
random_name=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 10 | head -n 1)
s3_bucket_name="terraform-state-bucket-${random_name}"

# Create the S3 bucket
aws s3api create-bucket --bucket "${s3_bucket_name}" --region us-east-1

# Create the DynamoDB table
aws dynamodb create-table \
    --table-name "terraform-api-state" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region us-east-1

echo "S3 bucket '${s3_bucket_name}' and DynamoDB table 'terraform-api-state' created successfully."
echo "Please update the 'backend.tf' file with the correct values before running 'terraform init'."