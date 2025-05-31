terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  name_prefix = "todo-app"
  tags = {
    Name        = "${local.name_prefix}-route53"
    Environment = var.environment
    Project     = "todo-app"
    ManagedBy   = "terraform"
  }
}

resource "aws_route53_zone" "main" {
  name = var.domain_name
  tags = local.tags
}

resource "aws_route53_record" "main" {
  count   = length(var.records)
  zone_id = aws_route53_zone.main.zone_id
  name    = lookup(var.records[count.index], "name", null)
  type    = lookup(var.records[count.index], "type", null)
  ttl     = lookup(var.records[count.index], "ttl", 300)
  records = lookup(var.records[count.index], "records", [])
}
