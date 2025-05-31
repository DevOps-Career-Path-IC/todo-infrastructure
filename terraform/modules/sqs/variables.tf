variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ARN of the ECS task role that needs to access the queue"
  type        = string
}
