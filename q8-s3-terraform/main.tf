provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "jashanveer-pbl2-q8-bucket"

  tags = {
    Name    = "Jashanveer-Q8-Bucket"
    Project = "VLE-PBL-II"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.mybucket.bucket
}