# Experiment: 4

variable "template" {
  type    = string
  default = "01000000-0000-4000-8000-000030080200"
}
output "string_output" {
  value = var.template
}

variable "users" {
  type    = list(any)
  default = ["root", "user1", "user2"]
}

output "list_output" {
  value = var.users
}

variable "plans" {
  type = map(any)
  default = {
    "5USD"  = "1xCPU-1GB"
    "10USD" = "1xCPU-2GB"
    "20USD" = "2xCPU-4GB"
  }
}

output "Maps_output" {
  value = var.plans
}

variable "set_password" {
  default = false
}

output "Boolean_output" {
  value = var.set_password
}
