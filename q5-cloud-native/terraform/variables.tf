variable "aws_region" {
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "Ubuntu 22.04 LTS AMI for ap-south-1"
  default     = "ami-095cc90aa5ddff518"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t2.micro"
}