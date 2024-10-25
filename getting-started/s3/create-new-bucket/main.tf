provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

resource "aws_s3_bucket" "nholuong_sample_s3_bucket" {
  bucket = "nholuong-sample-s3-bucket"

  tags = {
    Name        = "S3 bucket to store code"
    Environment = "Dev"
  }
}
