provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

resource "aws_s3_bucket" "nholuong_app_code" {
  bucket = "nholuong-app-code"

  tags = {
    Name        = "S3 bucket to store code"
    Environment = "Dev"
  }
}
