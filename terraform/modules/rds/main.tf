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
    Name        = "${var.name_prefix}-rds"
    Environment = var.environment
    Project     = var.name_prefix
    ManagedBy   = "terraform"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.name_prefix}-${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_parameter_group" "main" {
  name   = "${var.name_prefix}-${var.environment}-db-params"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  tags = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "main" {
  identifier             = "${var.name_prefix}-${var.environment}-db"
  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  storage_type           = "gp2"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = aws_db_parameter_group.main.name
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.app_security_group_id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az              = false
  deletion_protection    = false

  tags = local.tags

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
  }

  # Add explicit dependency on subnet group and parameter group
  depends_on = [
    aws_db_subnet_group.main,
    aws_db_parameter_group.main
  ]
}
