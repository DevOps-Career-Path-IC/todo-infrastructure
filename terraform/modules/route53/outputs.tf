output "zone_id" {
  description = "The ID of the hosted zone."
  value       = aws_route53_zone.main.zone_id
}

output "name_servers" {
  description = "The name servers for the hosted zone."
  value       = aws_route53_zone.main.name_servers
}
