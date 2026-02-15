resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_glue_catalog_database" "this" {
  name = "terraform_glue_db_${random_string.suffix.result}"
}
