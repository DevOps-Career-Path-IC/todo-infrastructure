# Create RDS security group
module "rds_sg" {
  source = "../../modules/security_groups"

  name_prefix   = local.name_prefix
  environment   = var.environment
  vpc_id        = module.vpc.vpc_id
  resource_name = "rds"

  ingress_rules = [
    {
      description     = "Allow PostgreSQL access from ECS tasks"
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      security_groups = [module.ecs_sg.security_group_id]
    },
    {
      description = "Allow access from local machine"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Note: In production, you should restrict this to your specific IP
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

# Create RDS instance
module "rds" {
  source = "../../modules/rds"

  name_prefix                 = local.name_prefix
  environment                 = var.environment
  vpc_id                      = module.vpc.vpc_id
  private_subnet_ids          = module.vpc.private_subnet_ids
  app_security_group_id       = module.rds_sg.security_group_id
  ecs_tasks_security_group_id = module.ecs_sg.security_group_id
  instance_class              = var.rds_instance_class
  allocated_storage           = var.rds_allocated_storage
  max_allocated_storage       = var.rds_max_allocated_storage
  db_username                 = var.db_username
  db_password                 = var.db_password
  db_name                     = var.db_name
}
