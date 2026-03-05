variable "agent_name" {
  description = "Name of the Bedrock agent"
  type        = string
}

variable "foundation_model" {
  description = "Foundation model for the agent"
  type        = string
  default     = "anthropic.claude-v2"
}

variable "s3_bucket_arn" {
  description = "S3 bucket containing knowledge base data"
  type        = string
}