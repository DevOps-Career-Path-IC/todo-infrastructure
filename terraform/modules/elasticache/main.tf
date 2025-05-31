terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  tags = {
    Name        = "${var.name_prefix}-redis"
    Environment = var.environment
    Project     = var.name_prefix
    ManagedBy   = "terraform"
  }
}

resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.name_prefix}-${var.environment}-redis-subnet"
  subnet_ids = var.private_subnet_ids
}

resource "aws_elasticache_parameter_group" "main" {
  name   = "${var.name_prefix}-${var.environment}-redis-params"
  family = "redis7"

  parameter {
    name  = "maxmemory-policy"
    value = "allkeys-lru"
  }
}

resource "aws_elasticache_replication_group" "main" {
  replication_group_id       = "${var.name_prefix}-${var.environment}-redis"
  description                = "Redis cluster for ${var.name_prefix} ${var.environment}"
  node_type                  = var.node_type
  port                       = 6379
  parameter_group_name       = aws_elasticache_parameter_group.main.name
  subnet_group_name          = aws_elasticache_subnet_group.main.name
  security_group_ids         = [var.app_security_group_id, var.ecs_tasks_sg_id]
  automatic_failover_enabled = false
  num_cache_clusters         = 1
  apply_immediately         = true

  lifecycle {
    create_before_destroy = true
  }

  tags = local.tags
}
