variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "allowed_cidr_blocks" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "database_name" {
  type = string
  default = "dev"
}

variable "master_username" {
  type = string
}

variable "master_password" {
  type = string
  sensitive = true
}

variable "node_type" {
  type = string
  default = "dc2.large"
}

variable "cluster_type" {
  type = string
  default = "single-node"
}

variable "number_of_nodes" {
  type = number
  default = 2
}

variable "publicly_accessible" {
  type = bool
  default = true
}