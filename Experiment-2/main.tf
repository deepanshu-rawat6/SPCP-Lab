# Experiment: 2

# Create a S3 bucket
# Enable versioning on the S3 bucket
# Add an upload files from folder to the S3 bucket
# Give public access to the S3 bucket

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.34.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

# resource "aws_instance" "example" {
#  ami = "ami-0c7217cdde317cfec"  #  Ubuntu 22.04 LTS
#  instance_type = "t2.micro"

#  tags = {
#    Name = "terraform-example"
#  }
# }

resource "aws_s3_bucket" "example" {
  bucket = "zephyrus-examples3-bucket"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.example.id
  acl    = "public-read"
}

resource "aws_s3_bucket_public_access_block" "example" {
    bucket = aws_s3_bucket.example.id

    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false
}

resource "aws_s3_object" "name" {
    bucket = aws_s3_bucket.example.id

    for_each = fileset("uploads", "**/*.*")
    key = each.key
    source = "uploads/${each.key}"
    content_type = each.value
}