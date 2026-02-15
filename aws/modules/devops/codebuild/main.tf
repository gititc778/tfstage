resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_iam_role" "codebuild_role" {
  name = "terraform-codebuild-role-${random_string.suffix.result}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_admin" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_codebuild_project" "this" {
  name         = "terraform-codebuild-${random_string.suffix.result}"
  service_role = aws_iam_role.codebuild_role.arn

  source {
    type     = "CODECOMMIT"
    location = var.repository_name
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:7.0"
    type         = "LINUX_CONTAINER"
  }
}
