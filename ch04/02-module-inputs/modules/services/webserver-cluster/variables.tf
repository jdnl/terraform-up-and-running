
variable "server_port" {
  description = "Web server incoming HTTP port"
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "Name to use for all cluster resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "Name of the S3 bucket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "Path for the database's remote state in S3"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance to run (e.g. t2.micro)"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum count of EC2 instances in the ASG"
  type = number
}

variable "asg_max_size" {
  description = "Maximum count of EC2 instances in the ASG"
  type = number
}
