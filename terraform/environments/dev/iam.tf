module "iam" {
  source         = "../../modules/iam"
  name_prefix    = local.name_prefix
  environment    = var.environment
  aws_region     = var.aws_region
  aws_account_id = var.aws_account_id

  roles = {
    ecs_execution = {
      name = "ecsTaskExecutionRole"
      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
              Service = "ecs-tasks.amazonaws.com"
            }
          }
        ]
      })
      policies = {
        ecr = {
          name        = "ecs-execution-ecr-policy"
          description = "Policy for ECR access from ECS tasks"
          policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
              {
                Effect = "Allow"
                Action = [
                  "ecr:*",
                  "logs:*",

                ]
                Resource = [
                  "*"
                ]
              }
            ]
          })
        }
      }
    }
    ecs_task = {
      name = "ecsTaskRole"
      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
              Service = "ecs-tasks.amazonaws.com"
            }
          }
        ]
      })
      policies = {
        rds = {
          name        = "ecs-task-rds-policy"
          description = "Policy for RDS access from ECS tasks"
          policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
              {
                Effect = "Allow"
                Action = [
                  "rds-db:connect"
                ]
                Resource = [
                  "arn:aws:rds:${var.aws_region}:${var.aws_account_id}:db:${local.name_prefix}-${var.environment}-*"
                ]
              }
            ]
          })
        }
        cloudwatch = {
          name        = "ecs-task-cloudwatch-policy"
          description = "Policy for CloudWatch Logs access from ECS tasks"
          policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
              {
                Effect = "Allow"
                Action = [
                  "logs:CreateLogGroup",
                  "logs:CreateLogStream",
                  "logs:PutLogEvents",
                  "logs:DescribeLogStreams"
                ]
                Resource = [
                  "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:log-group:/${local.name_prefix}/${var.environment}/*"
                ]
              }
            ]
          })
        }
      }
    }
    app = {
      name = "app-role"
      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
              Service = "ec2.amazonaws.com"
            }
          }
        ]
      })
      policies = {
        sqs = {
          name        = "app-sqs-policy"
          description = "Policy for SQS access"
          policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
              {
                Effect = "Allow"
                Action = [
                  "sqs:SendMessage",
                  "sqs:ReceiveMessage",
                  "sqs:DeleteMessage",
                  "sqs:GetQueueAttributes",
                  "sqs:ChangeMessageVisibility"
                ]
                Resource = [
                  "arn:aws:sqs:${var.aws_region}:${var.aws_account_id}:${local.name_prefix}-${var.environment}-*"
                ]
              }
            ]
          })
        }
        s3 = {
          name        = "app-s3-policy"
          description = "Policy for S3 access"
          policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
              {
                Effect = "Allow"
                Action = [
                  "s3:GetObject",
                  "s3:PutObject",
                  "s3:DeleteObject",
                  "s3:ListBucket"
                ]
                Resource = [
                  "arn:aws:s3:::${local.name_prefix}-${var.environment}-*",
                  "arn:aws:s3:::${local.name_prefix}-${var.environment}-*/*"
                ]
              }
            ]
          })
        }
        rds = {
          name        = "app-rds-policy"
          description = "Policy for RDS access"
          policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
              {
                Effect = "Allow"
                Action = [
                  "rds-db:connect",
                  "rds:DescribeDBInstances",
                  "rds:DescribeDBClusters",
                  "rds:DescribeDBParameterGroups",
                  "rds:DescribeDBParameters",
                  "rds:DescribeDBSecurityGroups",
                  "rds:DescribeDBSnapshots",
                  "rds:DescribeDBSubnetGroups",
                  "rds:DescribeEventSubscriptions",
                  "rds:DescribeEvents",
                  "rds:DescribeOptionGroups",
                  "rds:DescribeOrderableDBInstanceOptions",
                  "rds:DescribePendingMaintenanceActions",
                  "rds:DescribeReservedDBInstances",
                  "rds:DescribeReservedDBInstancesOfferings"
                ]
                Resource = [
                  "arn:aws:rds:${var.aws_region}:${var.aws_account_id}:db:${local.name_prefix}-${var.environment}-*",
                  "arn:aws:rds:${var.aws_region}:${var.aws_account_id}:cluster:${local.name_prefix}-${var.environment}-*"
                ]
              }
            ]
          })
        }
      }
    }
    worker = {
      name = "worker-role"
      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
              Service = "ecs-tasks.amazonaws.com"
            }
          }
        ]
      })
      policies = {
        sqs = {
          name        = "worker-sqs-policy"
          description = "Policy for SQS access"
          policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
              {
                Effect = "Allow"
                Action = [
                  "sqs:ReceiveMessage",
                  "sqs:DeleteMessage",
                  "sqs:GetQueueAttributes",
                  "sqs:ChangeMessageVisibility"
                ]
                Resource = [
                  "arn:aws:sqs:${var.aws_region}:${var.aws_account_id}:${local.name_prefix}-${var.environment}-*"
                ]
              }
            ]
          })
        }
      }
    }
  }
}
