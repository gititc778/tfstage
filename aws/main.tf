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

  cidr_block = "10.0.0.0/16"
}

################################
# EC2 MODULE
################################

module "ec2" {
  source   = "./modules/ec2"
  for_each = contains(var.services_to_deploy, "ec2") ? { ec2 = true } : {}

  subnet_id = module.vpc["network"].public_subnet_id
}