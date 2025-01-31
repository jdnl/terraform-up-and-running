output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
  description = "ARN of the S3 bucket for state tracking"
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
  description = "Table name of the DynamoDB lock file"
}
