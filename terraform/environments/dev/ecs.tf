# Create ECS tasks security group
module "ecs_sg" {
  source = "../../modules/security_groups"

  name_prefix   = local.name_prefix
  environment   = var.environment
  vpc_id        = module.vpc.vpc_id
  resource_name = "ecs-tasks"
  app_port      = var.app_port

  ingress_rules = [
    {
      description     = "Allow traffic from ALB"
      from_port       = var.app_port
      to_port         = var.app_port
      protocol        = "tcp"
      security_groups = [module.alb_sg.security_group_id]
    }
  ]

  egress_rules = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# Create ECS cluster and services
module "ecs" {
  source = "../../modules/ecs"

  name_prefix            = local.name_prefix
  environment            = var.environment
  aws_region             = var.aws_region
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = module.vpc.private_subnet_ids
  alb_security_group_id  = module.alb_sg.security_group_id
  alb_target_group_arn   = module.alb.target_group_arn
  ecs_execution_role_arn = module.iam.ecs_execution_role_arn
  ecs_task_role_arn      = module.iam.ecs_task_role_arn
  app_task_cpu           = 256
  app_task_memory        = 1024
  worker_task_cpu        = 256
  worker_task_memory     = 512
  app_image              = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${local.name_prefix}-${var.environment}:api-latest"
  worker_image           = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${local.name_prefix}-${var.environment}:worker-latest"
  app_port               = var.app_port
  postgres_host          = module.rds.db_instance_address
  postgres_db            = var.db_name
  postgres_user          = var.db_username
  postgres_password      = var.db_password
  redis_host             = module.elasticache.redis_endpoint
  redis_port             = 6379
  sqs_queue_url          = "https://sqs.${var.aws_region}.amazonaws.com/${var.aws_account_id}/${local.name_prefix}-${var.environment}-queue"
  sqs_dlq_url            = "https://sqs.${var.aws_region}.amazonaws.com/${var.aws_account_id}/${local.name_prefix}-${var.environment}-dlq"
  sqs_queue_name         = "${local.name_prefix}-${var.environment}-queue"
  sqs_endpoint           = "https://sqs.${var.aws_region}.amazonaws.com"
  sqs_region             = var.aws_region
  ecs_service_sg_id      = module.ecs_sg.security_group_id
}
