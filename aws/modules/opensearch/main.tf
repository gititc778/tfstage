resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_opensearch_domain" "this" {
  domain_name    = "terraform-opensearch-${random_string.suffix.result}"
  engine_version = "OpenSearch_2.11"

  cluster_config {
    instance_type = "t3.small.search"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  access_policies = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = "*"
      Action = "es:*"
      Resource = "*"
    }]
  })
}
