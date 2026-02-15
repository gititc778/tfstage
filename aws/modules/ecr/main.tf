resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_ecr_repository" "this" {
  name = "${var.repository_name}-${random_string.suffix.result}"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true
}
