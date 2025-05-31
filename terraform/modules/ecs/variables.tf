variable "name_prefix" {
  description = "Prefix to be used for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID of the ALB"
  type        = string
}

variable "alb_target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "ecs_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "app_task_cpu" {
  description = "CPU units for the API task"
  type        = number
  default     = 1024
}

variable "app_task_memory" {
  description = "Memory for the API task in MB"
  type        = number
  default     = 2048
}

variable "worker_task_cpu" {
  description = "CPU units for the worker task"
  type        = number
  default     = 1024
}

variable "worker_task_memory" {
  description = "Memory for the worker task in MB"
  type        = number
  default     = 2048
}

variable "app_image" {
  description = "Docker image for the API service"
  type        = string
}

variable "app_image_tag" {
  description = "Tag for the API service Docker image"
  type        = string
  default     = "latest"
}

variable "worker_image" {
  description = "Docker image for the worker service"
  type        = string
}

variable "worker_image_tag" {
  description = "Tag for the worker service Docker image"
  type        = string
  default     = "latest"
}

variable "app_port" {
  description = "Port exposed by the API container"
  type        = number
  default     = 3001
}

variable "postgres_host" {
  description = "PostgreSQL host"
  type        = string
}

variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
}

variable "postgres_user" {
  description = "PostgreSQL username"
  type        = string
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}

variable "redis_host" {
  description = "Redis host"
  type        = string
}

variable "redis_port" {
  description = "Redis port"
  type        = string
  default     = "6379"
}

variable "sqs_queue_url" {
  description = "URL of the SQS queue"
  type        = string
}

variable "sqs_dlq_url" {
  description = "URL of the SQS dead-letter queue"
  type        = string
}

variable "sqs_queue_name" {
  description = "Name of the SQS queue"
  type        = string
}

variable "sqs_endpoint" {
  description = "SQS endpoint URL"
  type        = string
}

variable "sqs_region" {
  description = "AWS region for SQS"
  type        = string
}

variable "ecs_service_sg_id" {
  description = "Security group ID of the ECS service"
  type        = string
}
