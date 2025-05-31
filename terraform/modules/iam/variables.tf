variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "roles" {
  description = "Map of IAM roles to create"
  type = map(object({
    name               = string
    assume_role_policy = string
    policies = map(object({
      name        = string
      description = string
      policy      = string
    }))
  }))
}
