variable "name_prefix" {
  description = "Prefix to be used for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ElastiCache cluster will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the ElastiCache cluster"
  type        = list(string)
}

variable "app_security_group_id" {
  description = "Security group ID of the application that needs to access Redis"
  type        = string
}

variable "node_type" {
  description = "Compute and memory capacity of the nodes"
  type        = string
  default     = "cache.t3.micro"
}

variable "ecs_tasks_sg_id" {
  description = "Security group ID of the ECS tasks"
  type        = string
}
