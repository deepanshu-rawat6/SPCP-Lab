# Experiment-6: Create multiple instances using for_each loop

provider "aws" {
  region = "ap-south-1"
}

variable "configs" {
  type = list(object({
    application_name = string
    ami              = string
    no_of_instances  = number
    instance_type    = string
  }))
  default = [
    {
      "application_name" : "App-1",
      "ami" : "ami-007020fd9c84e18c7",
      "no_of_instances" : "2",
      "instance_type" : "t2.micro",
    },
    {
      "application_name" : "2-dev",
      "ami" : "ami-007020fd9c84e18c7",
      "instance_type" : "t2.micro",
      "no_of_instances" : "1"
    },
    {
      "application_name" : "3-dev",
      "ami" : "ami-007020fd9c84e18c7",
      "instance_type" : "t2.micro",
      "no_of_instances" : "3"
    }

  ]
}

locals {
  s_configs = [
    for srv in var.configs : [
      for i in range(1, srv.no_of_instances + 1) : {
        instance_name = "${srv.application_name}-${i}"
        instance_type = srv.instance_type
        ami           = srv.ami
      }
    ]
  ]
}

locals {
  instances = flatten(local.s_configs)
}

resource "aws_instance" "lab_4_part_2" {
  for_each      = { for inst in local.instances : inst.instance_name => inst }
  ami           = each.value.ami
  instance_type = each.value.instance_type
  tags = {
    Name = each.value.instance_name
  }
}

output "instances" {
  value       = aws_instance.lab_4_part_2
  description = "instances created in part-2"
}
