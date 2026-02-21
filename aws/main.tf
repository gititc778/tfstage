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
    contains(var.services_to_deploy, "redshift")
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
  private_subnet_ids = module.vpc["network"].public_subnet_id
  db_username        = var.rds_db_username
  db_password        = var.rds_db_password
}

################################
# LAMBDA MODULE #SS
################################

# module "lambda" {
#   source   = "./modules/lambda"
#   for_each = contains(var.services_to_deploy, "lambda") ? { lambda = true } : {}

#   subnet_ids         = module.vpc["network"].private_subnet_ids
#   vpc_id             = module.vpc["network"].vpc_id
# }


################################
# ECR MODULE
################################

module "ecr" {
  source   = "./modules/ecr"
  for_each = contains(var.services_to_deploy, "ecr") ? { ecr = true } : {}

  repository_name = var.ecr_repository_name
}


################################
# SNS MODULE
################################

module "sns" {
  source   = "./modules/sns"
  for_each = contains(var.services_to_deploy, "sns") ? { sns = true } : {}
}


################################
# DevOps MODULE
################################
module "codecommit" {
  source   = "./modules/devops/codecommit"
  for_each = contains(var.services_to_deploy, "codecommit") ? { codecommit = true } : {}
}

module "codebuild" {
  source          = "./modules/devops/codebuild"
  for_each        = contains(var.services_to_deploy, "codebuild") ? { codebuild = true } : {}
  repository_name = module.codecommit["codecommit"].repository_name
}

module "codepipeline" {
  source             = "./modules/devops/codepipeline"
  for_each           = contains(var.services_to_deploy, "codepipeline") ? { codepipeline = true } : {}
  repository_name    = module.codecommit["codecommit"].repository_name
  build_project_name = module.codebuild["codebuild"].project_name
}

################################
# GLUE MODULE
################################

module "glue" {
  source   = "./modules/glue"
  for_each = contains(var.services_to_deploy, "glue") ? { glue = true } : {}
}

################################
# Opensearch MODULE
################################

module "opensearch" {
  source   = "./modules/opensearch"
  for_each = contains(var.services_to_deploy, "opensearch") ? { opensearch = true } : {}
}

################################
# Sagemaker MODULE
################################


module "sagemaker" {
  source                 = "./modules/sagemaker"
  for_each               = contains(var.services_to_deploy, "sagemaker") ? { sagemaker = true } : {}
  notebook_instance_type = var.notebook_instance_type
}

################################
# Quicksight MODULE
################################

module "quicksight" {
  source   = "./modules/quicksight"
  for_each = contains(var.services_to_deploy, "quicksight") ? { quicksight = true } : {}
}


################################
# REDSHIFT MODULE
################################

module "redshift" {
  source   = "./modules/redshift"
  for_each = contains(var.services_to_deploy, "redshift") ? { redshift = true } : {}

  vpc_id     = module.vpc["network"].vpc_id
  subnet_ids = module.vpc["network"].public_subnet_id

  master_username = var.redshift_master_username
  master_password = var.redshift_master_password

  allowed_cidr_blocks = [var.vpc_cidr_block]
}