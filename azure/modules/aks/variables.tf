variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "vnet_name" { type = string }
variable "subnet_prefix" { type = list(string) }

variable "vm_size" { type = string }
variable "node_count" { type = number }

variable "tags" {
  type    = map(string)
  default = {}
}