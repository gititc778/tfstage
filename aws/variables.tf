
variable "aws_region" {
  type = string
}

variable "services_to_deploy" {
  description = "List of services to deploy"
  type        = list(string)
  default     = []
}

variable "vpc_cidr_block" {
  type = string
}

variable "ec2_ami" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}

variable "s3_bucket_prefix" {
  type = string
}

variable "rds_db_username" {
  type = string
}

variable "rds_db_password" {
  type      = string
  sensitive = true
}
