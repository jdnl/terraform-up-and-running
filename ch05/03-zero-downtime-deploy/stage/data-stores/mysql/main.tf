terraform {
  backend "s3" {
    key    = "stage/data-stores/mysql/terraform.tfstate"
    // Remaining values are filled in by backend.hcl
    // Use `terraform init -backend-config=backend.hcl`
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true
  db_name             = "example_database_stage"

  // These secrets will be filled with environment variables for now
  username = var.db_username
  password = var.db_password
}
