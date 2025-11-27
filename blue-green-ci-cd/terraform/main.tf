# -------------------------
# Provider Configuration
# -------------------------
provider "aws" {
  region = var.aws_region
}

# -------------------------
# Variables
# -------------------------
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"   # Mumbai region
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-0c02fb55956c7d316"  # Amazon Linux 2
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "env" {
  description = "Environment name (INT or PROD)"
  type        = string
  default     = "INT"
}

# -------------------------
# Resources — Two EC2 Instances
# -------------------------
resource "aws_instance" "docker_server" {
  count         = 2
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "${var.env}-docker-server-${count.index == 0 ? "blue" : "green"}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user"
    ]
  }

  # Optional: allow SSH access from your IP
  # Add security group if needed
}

# -------------------------
# Outputs
# -------------------------
output "docker_server_ips" {
  description = "Public IPs of the Docker servers (Blue and Green)"
  value       = [for instance in aws_instance.docker_server : instance.public_ip]
}

output "docker_server_ids" {
  description = "Instance IDs of the Docker servers"
  value       = [for instance in aws_instance.docker_server : instance.id]
}
