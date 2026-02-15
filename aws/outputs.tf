output "vpc_id" {
  value = try(module.vpc["network"].vpc_id, null)
}
