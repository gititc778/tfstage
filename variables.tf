variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "project-databricks-terraform"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westus2"
}

variable "sql_admin_login" {
  description = "SQL Admin username for Synapse"
  type        = string
  default     = "sqladmin"
}
