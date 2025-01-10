# Chapter Exercise: Auto Scaling Group with Launch Template

This Terraform configuration sets up an Auto Scaling Group (ASG) in AWS with EC2 instances.

## What It Does
- Creates EC2 instances using a Launch Template.
- Automatically scales between 1 and 4 instances.
- Allows HTTP traffic on port 8080.
- Runs a web server that serves "Hello, World".

## How to Run
1. Initialize Terraform and Apply:
   ```bash
   terraform init
   terraform apply
   ```
2. Cleanup
   ```bash
   terraform destroy
   ```
