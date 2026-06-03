###############################################
# Q5: Automated Cloud-Native Application 
#     Deployment with Monitoring
# Terraform Configuration - EC2 Infrastructure
###############################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# --- SSH Key Pair ---
resource "aws_key_pair" "devops_key" {
  key_name   = "devops-key"
  public_key = file("${path.module}/devops-key.pub")
}

# --- Security Group ---
resource "aws_security_group" "app_sg" {
  name        = "cloud-native-app-sg"
  description = "Allow SSH, HTTP, App, and Monitoring ports"

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP (Nginx)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Application Port
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Prometheus
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Grafana
  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Node Exporter
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # cAdvisor
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "cloud-native-app-sg"
    Project = "VLE-PBL-Q5"
  }
}

# --- EC2 Instance ---
resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name    = "CloudNative-App-Server"
    Project = "VLE-PBL-Q5"
  }
}

# --- Generate Ansible Inventory ---
resource "local_file" "ansible_inventory" {
  content = <<-EOT
    [app_servers]
    ${aws_instance.app_server.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=../terraform/devops-key ansible_ssh_common_args='-o StrictHostKeyChecking=no'
  EOT

  filename = "${path.module}/../ansible/inventory.ini"
}