provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

resource "aws_s3_bucket" "nholuong_s3_website" {
  bucket = "nholuong-s3-website"

  tags = {
    Name        = "S3 bucket to store website"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.nholuong_s3_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.nholuong_s3_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "nholuong_s3_website_policy" {
  bucket = aws_s3_bucket.nholuong_s3_website.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.nholuong_s3_website.bucket}/*"
            ]
        }
    ]
}
POLICY
}

locals {
  index_html_source = "${path.module}/asset/index.html"
}

resource "aws_s3_object" "index_file_upload" {
  bucket      = "${aws_s3_bucket.nholuong_s3_website.bucket}"
  key         = "index.html"
  source      = local.index_html_source
  content_type = "text/html"
}


locals {
  error_html_source = "${path.module}/asset/error.html"
}

resource "aws_s3_object" "err_file_upload" {
  bucket      = "${aws_s3_bucket.nholuong_s3_website.bucket}"
  key         = "error.html"
  source      = local.error_html_source
  content_type = "text/html"
}