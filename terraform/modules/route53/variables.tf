variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the hosted zone"
  type        = string
}

variable "records" {
  description = "List of DNS records to create. Each record is a map with keys: name, type, ttl, records."
  type        = list(object({
    name    = string
    type    = string
    ttl     = optional(number, 300)
    records = list(string)
  }))
  default = []
}
