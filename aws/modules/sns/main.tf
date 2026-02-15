resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_sns_topic" "this" {
  name = "terraform-sns-${random_string.suffix.result}"

  tags = {
    Name = "terraform-sns-${random_string.suffix.result}"
  }
}
