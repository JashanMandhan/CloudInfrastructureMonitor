provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "jashan-p8-bucket-12345"

  tags = {
    Name = "Practice8-S3"
  }
}
