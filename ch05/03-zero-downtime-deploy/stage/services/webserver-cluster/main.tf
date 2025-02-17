terraform {
  backend "s3" {
    key = "stage/services/webserver-cluster/terraform.tfstate"
    // Remaining values are filled in by backend.hcl
    // Use `terraform init -backend-config=backend.hcl`
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  ami         = "ami-0e2c8caa4b6378d8c"
  server_text = "Hello, World! - 2nd version"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "jdnl-terraform-state-2"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  asg_min_size  = 2
  asg_max_size  = 2
}

output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "Domain name of the load balancer"
}
