variable "name_prefix" {
  description = "Prefix to be used for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "app_port" {
  description = "Port exposed by the application container"
  type        = number
  default     = 3001
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS listener"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "List of security group IDs for the ALB"
  type        = list(string)
}

