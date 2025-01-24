# Chapter 04: 01-Module-Basics

This project is a simple test to demonstrate using a Terraform module in a staging environment.

## Setup Order
1. **Global S3 Bucket**:
   Navigate to `global/s3` and apply the configuration to set up shared resources like the S3 bucket for state.
   ```bash
   cd global/s3
   terraform init
   terraform apply
   ```

2. **Data Stores**:
   Deploy data stores in the `stage/data-stores` directory.
   ```bash
   cd stage/data-stores
   terraform init
   terraform apply
   ```

3. **Services**:
   Deploy the services in the `stage/services` directory.
   ```bash
   cd stage/services
   terraform init
   terraform apply
   ```

## Notes
- Ensure the backend configuration is set correctly for each stage.
- This example is intended to help you understand module usage in Terraform.

