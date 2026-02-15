terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

    random = {
      source = "hashicorp/random"
    }
  }
}

################################
# NETWORK AUTO-TRIGGER LOGIC
################################

locals {
  needs_network = (
    contains(var.services_to_deploy, "ec2") ||
    contains(var.services_to_deploy, "eks") ||
    contains(var.services_to_deploy, "ecs") ||
    contains(var.services_to_deploy, "lambda") ||
    contains(var.services_to_deploy, "rds") ||
    contains(var.services_to_deploy, "opensearch") ||
    contains(var.services_to_deploy, "sagemaker")
  )
}

################################
# VPC MODULE
################################

module "vpc" {
  source   = "./modules/vpc"
  for_each = local.needs_network ? { network = true } : {}

  cidr_block = var.vpc_cidr_block

}

################################
# EC2 MODULE
################################

module "ec2" {
  source   = "./modules/ec2"
  for_each = contains(var.services_to_deploy, "ec2") ? { ec2 = true } : {}

  subnet_id     = module.vpc["network"].public_subnet_id
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
}


################################
# S3 MODULE
################################

module "s3" {
  source   = "./modules/s3"
  for_each = contains(var.services_to_deploy, "s3") ? { s3 = true } : {}

  bucket_prefix = var.s3_bucket_prefix

}

################################
# RDS MODULE
################################

module "rds" {
  source   = "./modules/rds"
  for_each = contains(var.services_to_deploy, "rds") ? { rds = true } : {}

  vpc_id             = module.vpc["network"].vpc_id
  private_subnet_ids = module.vpc["network"].private_subnet_ids
  db_username        = var.rds_db_username
  db_password        = var.rds_db_password
}

################################
# LAMBDA MODULE
################################

# module "lambda" {
#   source   = "./modules/lambda"
#   for_each = contains(var.services_to_deploy, "lambda") ? { lambda = true } : {}

#   subnet_ids         = module.vpc["network"].private_subnet_ids
#   vpc_id             = module.vpc["network"].vpc_id
# }
