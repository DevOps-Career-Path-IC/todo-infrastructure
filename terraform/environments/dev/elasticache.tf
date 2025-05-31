# Create Redis security group
module "redis_sg" {
  source = "../../modules/security_groups"

  name_prefix   = local.name_prefix
  environment   = var.environment
  vpc_id        = module.vpc.vpc_id
  resource_name = "redis"

  ingress_rules = [
    {
      description     = "Allow Redis access from ECS tasks"
      from_port       = 6379
      to_port         = 6379
      protocol        = "tcp"
      security_groups = [module.ecs_sg.security_group_id]
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

# Create ElastiCache Redis cluster
module "elasticache" {
  source = "../../modules/elasticache"

  name_prefix           = local.name_prefix
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  node_type             = var.redis_node_type
  app_security_group_id = module.redis_sg.security_group_id
  ecs_tasks_sg_id       = module.ecs_sg.security_group_id
}

module "elasticache_2" {
  source = "../../modules/elasticache"

  name_prefix           = "${local.name_prefix}-2"
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  node_type             = var.redis_node_type
  app_security_group_id = module.redis_sg.security_group_id
  ecs_tasks_sg_id       = module.ecs_sg.security_group_id
}
