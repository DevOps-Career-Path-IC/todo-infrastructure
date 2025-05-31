module "alb_sg" {
  source = "../../modules/security_groups"

  name_prefix   = local.name_prefix
  environment   = var.environment
  vpc_id        = module.vpc.vpc_id
  resource_name = "alb"

  ingress_rules = [
    {
      description = "Allow HTTP from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTPS from anywhere"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
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

# Create Application Load Balancer
module "alb" {
  source = "../../modules/alb"
  name_prefix           = local.name_prefix
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  app_port              = var.app_port
  security_group_ids    = [module.alb_sg.security_group_id]
}
