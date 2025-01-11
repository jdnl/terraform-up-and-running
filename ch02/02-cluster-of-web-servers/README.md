# Chapter Exercise: Auto Scaling Group with Launch Template and Application Load Balancer

This Terraform configuration sets up an Auto Scaling Group (ASG) in AWS with EC2 instances and integrates with an Application Load Balancer (ALB) for traffic management.

## What It Does
- Creates EC2 instances using a Launch Template.
- Automatically scales between 1 and 4 instances.
- Allows HTTP traffic on port 8080.
- Runs a web server that serves "Hello, World".
- Configures an Application Load Balancer (ALB) to distribute traffic across instances.
- Sets up health checks via the ALB to ensure traffic is routed to healthy instances.
- Automatically registers and deregisters instances with the ALB's target group.

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
