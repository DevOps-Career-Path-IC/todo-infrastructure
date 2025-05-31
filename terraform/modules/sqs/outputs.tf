output "queue_url" {
  description = "The URL of the created Amazon SQS queue"
  value       = aws_sqs_queue.main.url
}

output "queue_arn" {
  description = "The ARN of the created Amazon SQS queue"
  value       = aws_sqs_queue.main.arn
}

output "queue_name" {
  description = "The name of the created Amazon SQS queue"
  value       = aws_sqs_queue.main.name
}

output "dlq_url" {
  description = "The URL of the created Amazon SQS dead-letter queue"
  value       = aws_sqs_queue.dlq.url
}

output "dlq_arn" {
  description = "The ARN of the created Amazon SQS dead-letter queue"
  value       = aws_sqs_queue.dlq.arn
}
