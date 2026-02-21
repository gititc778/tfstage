output "glue_database_name" {
  value = aws_glue_catalog_database.this.name
}

output "glue_job_name" {
  value = aws_glue_job.this.name
}

output "glue_crawler_name" {
  value = aws_glue_crawler.this.name
}

output "data_bucket_name" {
  value = aws_s3_bucket.data_bucket.bucket
}

