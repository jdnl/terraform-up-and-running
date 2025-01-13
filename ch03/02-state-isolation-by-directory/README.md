# Chapter Exercise: Configuring a Remote Backend with S3 and DynamoDB

This Terraform configuration sets up a remote backend using an S3 bucket for storing the state file and DynamoDB for state locking.

## What It Does
- Configures a secure and centralized remote backend.
- Uses an S3 bucket to store the Terraform state file.
- Implements DynamoDB for state locking to prevent concurrent operations.
- Supports shared backend usage across multiple directories and environments.

## How to Run
1. Temporarily use the local backend:
   - Comment out the `terraform` backend block in `global/s3`:
     ```hcl
     # terraform {
     #   backend "s3" {
     #     key            = "global/s3/terraform.tfstate"
     #     ...
     #   }
     # }
     ```
   - Initialize Terraform:
     ```bash
     terraform init
     ```
   - Apply to create the S3 bucket and DynamoDB table:
     ```bash
     terraform apply
     ```

2. Switch to the remote backend:
   - Uncomment the `terraform` backend block.
   - Reinitialize Terraform with the remote backend:
     ```bash
     terraform init -backend-config=backend.hcl
     ```
   - Confirm the migration of the local state to the remote backend.

3. Use the backend in other directories:
   - Initialize Terraform with the shared backend configuration:
     ```bash
     terraform init -backend-config=backend.hcl
     ```