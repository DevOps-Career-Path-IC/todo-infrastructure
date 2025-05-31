output "redis_endpoint" {
  description = "The address of the endpoint for the primary node in the replication group"
  value       = aws_elasticache_replication_group.main.primary_endpoint_address
}

output "redis_port" {
  description = "The port number on which each of the nodes accepts connections"
  value       = aws_elasticache_replication_group.main.port
}

output "redis_replication_group_id" {
  description = "The ID of the ElastiCache Replication Group"
  value       = aws_elasticache_replication_group.main.id
}
