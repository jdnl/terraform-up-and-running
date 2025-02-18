# Terminology:
# alias - how to differentiate between different providers within the same project

# Normally these two provider blocks are required,
# but this example uses the localstack _providers.tf file instead

# provider "aws" {
#   region = "us-east-1"
#   alias  = "region_1"
# }

# provider "aws" {
#   region = "us-east-2"
#   alias  = "region_2"
# }

data "aws_region" "region_1" {
  provider = aws.region_1
}

data "aws_region" "region_2" {
  provider = aws.region_2
}

# data.<data_type>.<data_region>.<item>
output "region_1" {
  value       = data.aws_region.region_1.name
  description = "The name of the first region"
}

output "region_2" {
  value       = data.aws_region.region_2.name
  description = "The name of the second region"
}
