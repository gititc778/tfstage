resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_ecr_repository" "this" {
  name = "terraform-ecr-${random_string.suffix.result}"

  force_delete = true
}