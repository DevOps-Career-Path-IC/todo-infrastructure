# Create ECR repositories
module "ecr" {
  source = "../../modules/ecr"

  name_prefix = local.name_prefix
  environment = var.environment
  
}
