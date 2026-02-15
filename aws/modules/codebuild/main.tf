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
