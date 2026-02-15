resource "aws_opensearch_domain" "this" {
  domain_name = var.domain_name

  cluster_config {
    instance_type  = "t3.small.search"
    instance_count = 1
  }
}
