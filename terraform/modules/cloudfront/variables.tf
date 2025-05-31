variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "aliases" {
  description = "List of CNAMEs (aliases) for the distribution"
  type        = list(string)
  default     = []
}

variable "s3_bucket_domain_name" {
  description = "Domain name of the S3 bucket origin (e.g., bucket.s3.amazonaws.com)"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS (optional)"
  type        = string
  default     = null
}
