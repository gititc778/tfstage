terraform {
  backend "s3" {
    bucket         = "tfstate-euw2-dev-1"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}




provider "aws" {
  region = var.aws_region
}
