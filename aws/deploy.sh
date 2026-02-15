#!/bin/bash

BASE_DIR="modules"
mkdir -p $BASE_DIR

echo "Generating Terraform modules..."

#################################
# S3 MODULE
#################################
mkdir -p $BASE_DIR/s3
cat <<EOF > $BASE_DIR/s3/main.tf
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}
EOF

cat <<EOF > $BASE_DIR/s3/variables.tf
variable "bucket_name" {
  type = string
}
EOF

cat <<EOF > $BASE_DIR/s3/outputs.tf
output "bucket_id" {
  value = aws_s3_bucket.this.id
}
EOF


#################################
# RDS MODULE
#################################
mkdir -p $BASE_DIR/rds
cat <<EOF > $BASE_DIR/rds/main.tf
resource "aws_db_instance" "this" {
  identifier        = var.db_identifier
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  username          = var.username
  password          = var.password
  skip_final_snapshot = true
}
EOF

cat <<EOF > $BASE_DIR/rds/variables.tf
variable "db_identifier" { type = string }
variable "username" { type = string }
variable "password" { type = string }
EOF

cat <<EOF > $BASE_DIR/rds/outputs.tf
output "db_endpoint" {
  value = aws_db_instance.this.endpoint
}
EOF


#################################
# SNS MODULE
#################################
mkdir -p $BASE_DIR/sns
cat <<EOF > $BASE_DIR/sns/main.tf
resource "aws_sns_topic" "this" {
  name = var.topic_name
}
EOF

cat <<EOF > $BASE_DIR/sns/variables.tf
variable "topic_name" { type = string }
EOF

cat <<EOF > $BASE_DIR/sns/outputs.tf
output "topic_arn" {
  value = aws_sns_topic.this.arn
}
EOF


#################################
# OpenSearch MODULE
#################################
mkdir -p $BASE_DIR/opensearch
cat <<EOF > $BASE_DIR/opensearch/main.tf
resource "aws_opensearch_domain" "this" {
  domain_name = var.domain_name

  cluster_config {
    instance_type = "t3.small.search"
    instance_count = 1
  }
}
EOF

cat <<EOF > $BASE_DIR/opensearch/variables.tf
variable "domain_name" { type = string }
EOF

cat <<EOF > $BASE_DIR/opensearch/outputs.tf
output "domain_endpoint" {
  value = aws_opensearch_domain.this.endpoint
}
EOF


#################################
# Glue MODULE
#################################
mkdir -p $BASE_DIR/glue
cat <<EOF > $BASE_DIR/glue/main.tf
resource "aws_glue_catalog_database" "this" {
  name = var.database_name
}
EOF

cat <<EOF > $BASE_DIR/glue/variables.tf
variable "database_name" { type = string }
EOF

cat <<EOF > $BASE_DIR/glue/outputs.tf
output "database_name" {
  value = aws_glue_catalog_database.this.name
}
EOF


#################################
# CodeBuild MODULE
#################################
mkdir -p $BASE_DIR/codebuild
cat <<EOF > $BASE_DIR/codebuild/main.tf
resource "aws_codebuild_project" "this" {
  name         = var.project_name
  service_role = var.service_role

  artifacts { type = "NO_ARTIFACTS" }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:7.0"
    type         = "LINUX_CONTAINER"
  }

  source { type = "NO_SOURCE" }
}
EOF

cat <<EOF > $BASE_DIR/codebuild/variables.tf
variable "project_name" { type = string }
variable "service_role" { type = string }
EOF

cat <<EOF > $BASE_DIR/codebuild/outputs.tf
output "project_name" {
  value = aws_codebuild_project.this.name
}
EOF


#################################
# SageMaker MODULE
#################################
mkdir -p $BASE_DIR/sagemaker
cat <<EOF > $BASE_DIR/sagemaker/main.tf
resource "aws_sagemaker_notebook_instance" "this" {
  name          = var.name
  role_arn      = var.role_arn
  instance_type = "ml.t3.medium"
}
EOF

cat <<EOF > $BASE_DIR/sagemaker/variables.tf
variable "name" { type = string }
variable "role_arn" { type = string }
EOF

cat <<EOF > $BASE_DIR/sagemaker/outputs.tf
output "notebook_name" {
  value = aws_sagemaker_notebook_instance.this.name
}
EOF

echo "Terraform modules created successfully."
