resource "aws_sagemaker_notebook_instance" "this" {
  name          = var.name
  role_arn      = var.role_arn
  instance_type = "ml.t3.medium"
}
