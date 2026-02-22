
variable "services_to_deploy" {
  description = "List of services to deploy"
  type        = list(string)
  default     = []
}



variable "location" {
  description = "location"
  type        = string
}


variable "databricks_sku" {
  description = "Databricks SKU (standard or premium)"
  type        = string
  default     = "standard"
}


variable "sql_admin_login" {
  description = "Synapse SQL admin username"
  type        = string
}

variable "sql_admin_password" {
  description = "Synapse SQL admin password"
  type        = string
  sensitive   = true
}


variable "vm_size" {
  type = string
}

variable "vm_admin_username" {
  type = string
}

variable "vm_admin_password" {
  type      = string
  sensitive = true
}

variable "vnet_address_space" {
  type = list(string)
}



variable "vm_subnet_prefix" {
  
}

variable "aks_subnet_prefix" {
  
}

variable "aks_vm_size" { type = string }
variable "aks_node_count" { type = number }