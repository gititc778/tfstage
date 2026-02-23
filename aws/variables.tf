
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

variable "ecr_repository_name" {
  type = string
}

variable "notebook_instance_type" {
  type = string
}


variable "redshift_master_username" {
  type = string
}

variable "redshift_master_password" {
  type      = string
  sensitive = true
}


variable "rds_engine" {
  description = "RDS engine type"
  type        = string
}

variable "key_name" {
  type = string
}


variable "ecs_container_image" {
  type = string
}


variable "ec2_instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1

  validation {
    condition     = var.ec2_instance_count >= 1 && var.ec2_instance_count <= 3
    error_message = "You can deploy minimum 1 and maximum 3 EC2 instances."
  }
}