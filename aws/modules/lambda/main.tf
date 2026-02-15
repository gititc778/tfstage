resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

################################
# IAM Role
################################

resource "aws_iam_role" "this" {
  name = "terraform-lambda-role-${random_string.suffix.result}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

################################
# Attach Basic Execution Policy
################################

resource "aws_iam_role_policy_attachment" "basic" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

################################
# Attach VPC Access Policy
################################

resource "aws_iam_role_policy_attachment" "vpc" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

################################
# Security Group
################################

resource "aws_security_group" "this" {
  name   = "terraform-lambda-sg-${random_string.suffix.result}"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################
# Lambda Function
################################

resource "aws_lambda_function" "this" {
  function_name = "terraform-lambda-${random_string.suffix.result}"
  role          = aws_iam_role.this.arn
  runtime       = "nodejs18.x"
  handler       = "index.handler"

  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.this.id]
  }
}
