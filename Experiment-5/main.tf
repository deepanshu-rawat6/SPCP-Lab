# Experiment: 5

# use variables and spin up multiple ec2 instances


variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ami" {
  type    = string
  default = "ami-080e1f13689e07408"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "tags" {
  type = map(string)
  default = {
    Name = "spcm_lab_4_deepanshu-rawat"
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "deepanshu-rawat-ec2" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  tags          = var.tags
}
