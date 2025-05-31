terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  name_prefix = "todo-app"
  tags = {
    Name        = "${local.name_prefix}-secret"
    Environment = var.environment
    Project     = "todo-app"
    ManagedBy   = "terraform"
  }
}

resource "aws_secretsmanager_secret" "main" {
  name = "${local.name_prefix}-${var.environment}-${var.secret_name}"
  description = var.description
  tags = local.tags
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = var.secret_value
}
