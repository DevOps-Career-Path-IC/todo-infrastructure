# Create VPC and networking resources
module "vpc" {
  source = "../../modules/vpc"

  name_prefix        = local.name_prefix
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}
