resource "aws_quicksight_account_subscription" "this" {
  edition               = "STANDARD"
  authentication_method = "IAM_AND_QUICKSIGHT"
  account_name          = "terraform-quicksight-account"
  notification_email    = "admin@example.com"
}
