output "secret_arn" {
  description = "The ARN of the secret."
  value       = aws_secretsmanager_secret.main.arn
}

output "secret_name" {
  description = "The name of the secret."
  value       = aws_secretsmanager_secret.main.name
}
