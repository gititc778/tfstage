resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_codecommit_repository" "this" {
  repository_name = "terraform-repo-${random_string.suffix.result}"
}
