variable "function_name" { type = string }
variable "handler" { type = string }
variable "runtime" { type = string }
variable "role_arn" { type = string }
variable "filename" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
