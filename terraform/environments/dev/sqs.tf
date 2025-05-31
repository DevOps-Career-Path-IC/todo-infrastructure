# Create SQS queues
module "sqs" {
  source            = "../../modules/sqs"
  environment       = var.environment
  ecs_task_role_arn = module.iam.role_arns["ecs_task"]
}
