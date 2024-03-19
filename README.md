# Project Name

This project is an AWS API Gateway that uses Lambda as an endpoint. It is built using Terraform for infrastructure provisioning and management.

## Prerequisites

Before getting started, make sure you have the following:

- AWS CLI configured with your AWS credentials.
- Rename the `default-vars.tf` file to `variables.tf` and update it with your specific information.
- Run the `setup.sh` script to set up the necessary dependencies.
- Create a GitHub v2 connection for your AWS pipeline and update the `variables.tf` file with the ARN.

## Getting Started

To get started with this project, follow these steps:

1. Clone the repository to your local machine.
2. Navigate to the project directory: `/Users/dennisdiepolder/Documents/Dev/eagler-api`.
3. Rename the `default-vars.tf` file to `variables.tf` and update it with your specific information.
4. Run the `setup.sh` script to set up the necessary dependencies.
5. Run `terraform init` to initialize the Terraform configuration.

## Customizing the Code

To customize the code to fit your needs, follow these steps:

1. Open the `index.js` file and make the necessary changes to meet your requirements.
2. Save the changes.

## Deployment

Once you have customized the code, you can deploy it using the automated pipeline. The pipeline will push your code as needed.