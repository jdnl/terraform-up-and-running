terraform {
  backend "s3" {
    key    = "prod/services/webserver-cluster/terraform.tfstate"
    // Remaining values are filled in by backend.hcl
    // Use `terraform init -backend-config=backend.hcl`
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name = "webservers-prod"
  db_remote_state_bucket = "jdnl-terraform-state-2"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t3.micro"
  asg_min_size = 2
  asg_max_size = 4
}

output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "Domain name of the load balancer"
}
