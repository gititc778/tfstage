output "redshift_cluster_endpoint" {
  value = aws_redshift_cluster.this.endpoint
}

output "redshift_cluster_identifier" {
  value = aws_redshift_cluster.this.cluster_identifier
}

output "redshift_security_group_id" {
  value = aws_security_group.redshift_sg.id
}