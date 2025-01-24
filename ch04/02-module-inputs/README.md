# The simple readme, for meeting time requirements

## Purpose
Practice using module input variables, module outputs, and module locals.

## Order of operations
Comment out the backend config for global/s3/main.  
Initialize and apply so it builds the s3 bucket and dynamodb lock table.  
Uncomment the backend config.  
Initialize with `terraform init backend-config=backend.hcl`.

Create the staging and prod databases.  
Create the staging and prod webserver clusters.

