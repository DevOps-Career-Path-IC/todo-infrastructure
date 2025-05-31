output "role_arns" {
  description = "Map of role names to their ARNs"
  value       = { for k, v in aws_iam_role.roles : k => v.arn }
}

output "role_names" {
  description = "Map of role keys to their names"
  value       = { for k, v in aws_iam_role.roles : k => v.name }
}

output "policy_arns" {
  description = "Map of policy keys to their ARNs"
  value       = { for k, v in aws_iam_policy.policies : k => v.arn }
}

output "instance_profile_arns" {
  description = "Map of instance profile names to their ARNs"
  value       = { for k, v in aws_iam_instance_profile.profiles : k => v.arn }
}

output "instance_profile_names" {
  description = "Map of instance profile keys to their names"
  value       = { for k, v in aws_iam_instance_profile.profiles : k => v.name }
}

output "ecs_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.roles["ecs_execution"].arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = aws_iam_role.roles["ecs_task"].arn
}
