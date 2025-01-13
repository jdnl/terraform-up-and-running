terraform {
  backend "s3" {
    key    = "global/s3/terraform.tfstate"
    // Remaining values are filled in by backend.hcl
    // Use `terraform init -backend-config=backend.hcl`
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "jdnl-terraform-state"

  lifecycle {
    // Terraform-specific lifecycle setting that prevents deletion during `terraform destroy`
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.terraform_state.id
  // Prevent creation and updates of public ACLs for both objcets and bucket
  block_public_acls = true
  // Prevents creation and updates of bucket policies granting public access
  block_public_policy = true
  // Ignores public ACLs if they alredy exist or are somehow added in thte future
  ignore_public_acls = true
  // Don't allow bucket to become public
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
