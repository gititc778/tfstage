variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "services_to_deploy" {
  description = "List of services to deploy"
  type        = list(string)
  default     = []
}
