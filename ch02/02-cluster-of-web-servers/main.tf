provider "aws" {
  region = "us-east-1"
}

resource "aws_launch_template" "example" {
  image_id               = "ami-0e2c8caa4b6378d8c"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF
  )
}

resource "aws_autoscaling_group" "example" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 2
  min_size           = 1
  max_size           = 4

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  // Allow incoming traffic on 8080 from all IPs
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "server_port" {
  description = "Web server incoming HTTP port"
  type        = number
  default     = 8080
}

// Retrieve VPC data from AWS for use elsewhere in this file
// reference with data.aws_vpc.default.id
data "aws_vpc" "default" {
  default = true
}

// Retrieve ID of default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

