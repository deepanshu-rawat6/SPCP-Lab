# Experiment: 1

# Setup the AWS provider for terraform
# Configure the AWS provider with the access key and secret key
# Create a new EC2 with a tag

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

resource "aws_instance" "example" {
 ami = "ami-0c7217cdde317cfec"  #  Ubuntu 22.04 LTS
 instance_type = "t2.micro"

 tags = {
   Name = "terraform-example"
 }
}