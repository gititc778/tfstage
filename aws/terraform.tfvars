aws_region = "eu-west-2"

vpc_cidr_block    = "10.0.0.0/16"
ec2_ami           = "ami-0ba0c1a358147d1a8"
ec2_instance_type = "t3.micro"
key_name          = "terraform-keypair"

s3_bucket_prefix = "terraform-sandbox"

rds_db_username = "admin"
rds_db_password = "Terraform123!"
rds_engine      = "mysql"

ecr_repository_name = "terraform-sandbox-repo"


notebook_instance_type = "ml.t3.micro"


redshift_master_username = "admin"
redshift_master_password = "Terraform123!"

ecs_container_image = "nginx:latest"
