resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

data "archive_file" "lambda" {
  type = "zip"

  source {
    content  = <<EOF
def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": "placeholder lambda"
    }
EOF
    filename = "lambda_function.py"
  }

  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "this" {
  function_name = "terraform-lambda-${random_string.suffix.result}"

  role    = var.lambda_role_arn
  runtime = var.runtime
  handler = var.handler

  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256
}