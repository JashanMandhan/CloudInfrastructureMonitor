provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-02dfbd4ff395f2a1b"
  instance_type = "t3.micro"
  key_name      = "vockey"

  tags = {
    Name = "Terraform-Q7-Jashanveer"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}